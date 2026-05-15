# Lab 02 – IP fragmentation & ICMP attacks

## Objectives

- Learn about IP packet fragmentation and reassembly.
- Perform fragmentation attacks (e.g., overlapping fragments) to evade detection.
- Explore ICMP‑based attacks: Smurf, ping of death and ICMP redirects.
- Implement defences such as reverse‑path filtering and rate limiting.

## Background

The IP layer splits large datagrams into fragments that are reassembled at the destination.  Attackers send overlapping or conflicting fragments to confuse the reassembly code or evade signature‑based intrusion detection systems.  ICMP is a companion protocol used for diagnostics; it can be abused in Smurf attacks (ICMP echo requests to broadcast addresses with spoofed source IPs) and ping of death (oversized packets).  ICMP redirect messages can trick hosts into sending traffic to a malicious router.

## Tasks

1. **Fragmentation basics**  
   - In the `attacker` container, install `scapy` if not already (`pip3 install scapy`).  
   - Use Scapy to craft an IP packet to the client (`10.0.0.20`) that is fragmented into multiple pieces.  Send the fragments out of order and observe that the client reassembles them correctly.

2. **Overlapping fragments**  
   - Send two fragments whose data overlap; for example, send fragment offsets 0 and 2 with overlapping bytes.  Observe how the client handles the overlap.  
   - Try using `scapy.contrib.nmap` or `fragroute` (install via `apt install -y fragroute`) to automate fragmentation attacks.

3. **Smurf attack**  
   - Identify a broadcast address on the external network (e.g. `10.0.0.255`).  Use Scapy to send ICMP echo requests to the broadcast address with the `client`’s IP as the spoofed source.  Observe the flood of echo replies sent to the client.  
   - Measure the amplification effect by counting the number of replies.

4. **ICMP redirect**  
   - In `edge_router`, temporarily enable sending of ICMP redirects (`sysctl -w net.ipv4.conf.all.send_redirects=1`).  
   - From the attacker, craft an ICMP redirect packet to the client, indicating that traffic to `192.168.1.0/24` should be sent via `10.0.0.10` (attacker).  Observe the client’s routing table (`ip route`).  
   - Disable redirects after testing (`sysctl -w net.ipv4.conf.all.send_redirects=0`).

5. **Defences**  
   - Enable reverse‑path filtering on routers to drop packets with spoofed source addresses (`sysctl -w net.ipv4.conf.all.rp_filter=1`).  
   - Configure routers to ignore ICMP redirects and host to verify the gateway before updating routes.

Proceed to [Lab 03 – UDP amplification attacks](03-udp-amplification.html).
