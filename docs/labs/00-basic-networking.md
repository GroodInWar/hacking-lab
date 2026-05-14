# Lab 00 – Basic networking and reconnaissance

## Objectives

- Understand the lab topology and how the containers are connected.
- Review IP addresses, subnet masks and default gateways.
- Capture packets and spoof traffic using tools such as `tcpdump`, `Wireshark` or Python/Scapy.
- Practice simple reconnaissance techniques (ping, traceroute, port scanning).

## Background

A network is a collection of hosts and routers connected by links.  Each interface has an IP address and a subnet mask that defines which addresses are local.  When a host needs to send a packet to a non‑local address, it forwards the packet to its default gateway (a router).  The router uses its routing table to decide which interface to forward the packet on.

In Docker, bridge networks behave like virtual switches.  Hosts on the same bridge can communicate directly:contentReference[oaicite:1]{index=1}.  Packets between bridges are forwarded by routers.  The routers in this lab are Linux containers configured with `iproute2` to assign addresses, enable IP forwarding and install static routes.

## Tasks

1. **Explore the environment**  
   - Start the lab environment (`docker compose up -d` from the `docker/` directory).  
   - List running containers with `docker compose ps`.  Identify the IP address of each container using `docker compose exec <service> ip addr`.  
   - Draw a diagram of the network showing each subnet and host.

2. **Ping and traceroute**  
   - From the `attacker` container, install `iputils-ping` if necessary (`apt update && apt install -y iputils-ping`).  
   - Ping the `client` (`192.168.10.3`) and observe the replies.  
   - Use `traceroute` (install it via `apt install -y traceroute`) to trace the path to a DMZ host (`192.168.30.10`).  Note which routers the packets traverse.

3. **Packet sniffing**  
   - Install `tcpdump` in the `attacker` container (`apt install -y tcpdump`).  
   - Run `tcpdump -n -i eth0` to capture packets on the LAN interface.  Ping the client again and observe the ARP and ICMP packets.  
   - Try capturing on other interfaces by entering router containers (`docker compose exec router1 bash`) and running `tcpdump -n -i eth0` or `eth1`.

4. **Packet spoofing**  
   - Install Python and Scapy (`apt install -y python3 python3-pip && pip3 install scapy`).  
   - Write a simple Python script using Scapy to craft and send ICMP echo requests with a spoofed source IP.  Observe how the router forwards or drops the packets.

5. **Discussion**  
   - Explain why hosts on the same bridge network can communicate without a router.  
   - What happens if you assign two containers the same IP address?  
   - How might an attacker use packet sniffing in a real network?

Proceed to [Lab 01 – ARP poisoning](01-arp-poisoning.md) when you are comfortable with basic networking operations.
