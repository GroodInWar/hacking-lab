#!/bin/bash

# This entrypoint configures a container to act like a simple static
# router.  It reads environment variables describing interface
# addresses and static routes, applies them via iproute2, and then
# enables IPv4 forwarding.  Once configured the script executes the
# supplied command (by default an infinite sleep) so the container
# remains running.

set -e

echo "[router] Starting router configuration"

# Turn on IPv4 forwarding so the kernel will forward packets between
# interfaces.  Without this setting the router would drop any packet
# that is not destined for one of its own addresses.
sysctl -w net.ipv4.ip_forward=1 >/dev/null

# Assign addresses to all declared interfaces.  The environment
# variables IFACE0_IP, IFACE1_IP, IFACE2_IP, etc. should contain
# addresses with prefix lengths (e.g. 10.0.0.1/24).  The interface
# names inside the container follow Docker’s convention: eth0, eth1,
# eth2 … in the order networks are defined in docker‑compose.yml.
i=0
while true; do
    var="IFACE${i}_IP"
    eval value="\${$var}"
    if [[ -z "$value" ]]; then
        break
    fi
    iface="eth${i}"
    addr="$value"
    # Only configure the address if it is not already set
    if ip addr show "$iface" | grep -q "$addr"; then
        echo "[router] $iface already configured with $addr"
    else
        echo "[router] Assigning $addr to $iface"
        ip addr add "$addr" dev "$iface"
    fi
    # Bring the interface up
    ip link set "$iface" up
    i=$((i+1))
done

# Apply static routes.  The ROUTES variable accepts a semicolon‑
# separated list of entries in the form:
#   destination/prefix:next_hop:interface
# For example: 192.168.1.0/24:172.16.0.2:eth1
# Multiple entries should be separated by semicolons.  Whitespace is
# ignored and empty entries are skipped.
if [[ -n "$ROUTES" ]]; then
    routes=$(echo "$ROUTES" | tr -d '\n' )
    IFS=';' read -ra entries <<< "$routes"
    for entry in "${entries[@]}"; do
        entry="${entry// /}"
        if [[ -z "$entry" ]]; then
            continue
        fi
        dest=$(echo "$entry" | cut -d: -f1)
        gw=$(echo "$entry" | cut -d: -f2)
        dev=$(echo "$entry" | cut -d: -f3)
        if [[ -z "$dest" || -z "$gw" || -z "$dev" ]]; then
            echo "[router] Warning: invalid route entry '$entry'"
            continue
        fi
        echo "[router] Adding static route: $dest via $gw dev $dev"
        ip route replace "$dest" via "$gw" dev "$dev"
    done
fi

echo "[router] Configuration complete; forwarding enabled"

exec "$@"
