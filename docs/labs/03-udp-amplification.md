# Lab 03 – UDP amplification attacks

## Objectives

- Understand how UDP protocols can be abused for amplification.
- Launch a UDP amplification attack using an exposed service.
- Measure the effect on the victim and the network.
- Deploy mitigation strategies such as rate limiting and ingress filtering.

## Background

UDP is connectionless: there is no handshake, and responses are sent blindly to the source address.  Many protocols (DNS, NTP, SSDP) respond with more data than they receive.  Attackers send requests with a spoofed source IP (the victim) to these amplifiers; the amplifiers flood the victim with large responses.  The amplification factor is the ratio of response size to request size.

## Tasks

1. **Set up an amplifier**  
   - The lab includes an FTP server (`dmz_ftp`) that can be misused for amplification.  Identify other services (e.g. DNS or NTP) by scanning the DMZ with `nmap -sU 192.168.30.1-20`.  
   - Note the response sizes for common requests.

2. **Craft a UDP attack**  
   - Use Scapy to send a small UDP request to the amplifier with the client’s IP (`192.168.10.3`) as the spoofed source.  For FTP, send a `USER` command; for DNS (if installed), send a large `ANY` query.  
   - Observe the volume of traffic received by the client.  Use `tcpdump` on the client to capture the flood.

3. **Amplification factor**  
   - Calculate the amplification factor by comparing the size of the request you sent to the total bytes received by the victim.  
   - Try different protocols to see which yields the highest amplification.

4. **Mitigation**  
   - Implement rate limiting on the amplifier.  For example, configure `vsftpd` to limit connections or install an NTP server with `restrict default ignore` in its configuration.  
   - On routers, deploy ingress filtering: drop packets entering the network with a source IP that does not belong to the source network.  Enable this by adding iptables rules like `iptables -A INPUT -s ! 192.168.0.0/16 -j DROP`.

Proceed to [Lab 04 – TCP attacks and session hijacking](/labs/04-tcp-attacks/).
