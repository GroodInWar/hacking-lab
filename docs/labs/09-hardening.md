# Lab 09 – Network hardening and monitoring

## Objectives

- Combine previous defences to build a hardened enterprise network.
- Implement NAT, segmentation and least privilege.
- Deploy monitoring and intrusion detection.
- Re‑run earlier attacks to evaluate the effectiveness of your defences.

## Background

A secure network uses multiple layers of defence: segmentation (separate external network, DMZ and internal networks), NAT to hide internal addresses, firewalls and IDS/IPS, strong authentication, encrypted protocols and timely patching.  Hardening also involves disabling unnecessary services, limiting administrative access and monitoring for anomalies.

## Tasks

1. **Enable NAT**  
   - On `internal_router`, configure NAT for traffic leaving the internal network: `iptables -t nat -A POSTROUTING -s 10.1.0.0/24 ! -d 10.1.0.0/24 -j MASQUERADE`.  
   - Test that internal hosts can access external networks while their private addresses are hidden.

2. **Segment management and user traffic**  
   - Create a management VLAN or subnet for administrative access to routers and servers.  Assign unique IP ranges and restrict access to trusted hosts only.  
   - Use SSH with key‑based authentication instead of Telnet.

3. **Deploy IDS/IPS**  
   - Use Snort or Suricata on the firewall or on each subnet.  Configure rules to detect the attacks you performed in earlier labs (ARP poisoning, SYN floods, DNS poisoning, etc.).  
   - Set up log aggregation (e.g. with `rsyslog` or `ELK`) to centralise logs.

4. **Patch and update services**  
   - Regularly update the operating system and applications inside each container.  Use a vulnerability scanner such as OpenVAS to identify outdated software.  
   - Replace insecure services (FTP, Telnet) with secure alternatives (SFTP, SSH).

5. **Re‑run attacks**  
   - Attempt to perform the ARP poisoning, fragmentation, SYN flood, DNS poisoning and Heartbleed attacks again.  Document which attacks succeed and which are blocked or detected.  Adjust firewall and IDS rules accordingly.

6. **Discussion**  
   - What is defence in depth?  
   - How can you balance security with usability and performance?  
   - Which controls are most effective against the attacks you studied?

Congratulations!  You have completed the enterprise network security lab.  Consider exploring advanced topics such as BGP hijacking, PKI and certificate authorities or developing your own security tools.
