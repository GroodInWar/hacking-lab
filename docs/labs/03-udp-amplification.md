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
   - The lab includes a DNS server (`dns_server`, `192.168.1.30`) in the DMZ. Identify UDP services by scanning the DMZ with `nmap -sU 192.168.1.1-30`.  
   - Note the response sizes for common DNS requests and compare them with the request sizes.

2. **Craft a UDP attack**  
   - Use Scapy to send a small DNS request to `192.168.1.30` with the client’s IP (`10.0.0.20`) as the spoofed source. Try a large `ANY` query or another response-heavy query supported by your DNS configuration.  
   - Observe the volume of traffic received by the client.  Use `tcpdump` on the client to capture the flood.

3. **Amplification factor**  
   - Calculate the amplification factor by comparing the size of the request you sent to the total bytes received by the victim.  
   - Try different protocols to see which yields the highest amplification.

4. **Mitigation**  
   - Implement rate limiting on the DNS server and disable open-recursive behavior where it is not required.  
   - On routers, deploy ingress filtering: drop packets entering a segment with a source IP that does not belong to that segment. For example, on `edge_router`, drop external-interface traffic claiming to come from non-external networks.

Proceed to [Lab 04 – TCP attacks and session hijacking](04-tcp-attacks.html).
