# Lab 07 – Firewalls and evasion

## Objectives

- Understand the difference between packet filters, stateful firewalls and application proxies.
- Build a basic firewall using Linux netfilter (iptables/nftables).
- Write filtering rules to permit and block specific traffic.
- Develop evasion techniques and test firewall robustness.
- Optionally, deploy an intrusion detection system (IDS) such as Snort.

## Background

Firewalls enforce security policies by inspecting packets and deciding whether to forward, drop or modify them.  A packet filter examines headers (IP, TCP/UDP) but cannot track state.  A stateful firewall tracks connection state and can filter based on whether a packet belongs to an existing connection.  Application proxies operate at the application layer and can inspect payloads.

Attackers attempt to evade firewalls by fragmenting packets, tunnelling traffic (e.g. via VPNs), or using non‑standard ports.  Understanding these techniques helps defenders write robust rules and monitor anomalies.

## Tasks

1. **Enable forwarding and set default policies**  
   - In a new container `firewall` connected between router1 and router2, enable IP forwarding (`sysctl -w net.ipv4.ip_forward=1`).  
   - Flush existing iptables rules (`iptables -F`).  
   - Set default policies to `DROP` for all chains (`iptables -P INPUT DROP; iptables -P FORWARD DROP; iptables -P OUTPUT ACCEPT`).

2. **Write filtering rules**  
   - Allow established and related connections: `iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT`.  
   - Permit HTTP/HTTPS traffic from the LAN to the DMZ web server and DNS queries to the DNS server.  
   - Allow FTP only from the internal network to the DMZ.  
   - Deny all other inbound connections to the DMZ and internal networks.

3. **Test the firewall**  
   - Attempt to access the FTP server from the attacker (LAN); the firewall should block it.  
   - Access the web server from the client; the firewall should permit it.  
   - Run a port scan from the attacker and log the dropped attempts (`iptables -A FORWARD -j LOG --log-prefix "FW DROP: "`).

4. **Evasion**  
   - Fragment packets using `fragroute` or Scapy and observe whether the firewall reassembles them correctly.  
   - Try tunnelling traffic through ICMP or DNS.  Does the firewall detect and block these tunnels?  
   - Implement simple rate limiting with iptables (`-m limit`) to mitigate floods.

5. **IDS integration (optional)**  
   - Install Snort or Suricata on the firewall container.  
   - Configure rules to detect ARP poisoning, SYN floods and DNS rebinding.  
   - Generate alerts and observe them in log files.

Proceed to [Lab 08 – VPN tunnelling](/labs/08-vpn/).
