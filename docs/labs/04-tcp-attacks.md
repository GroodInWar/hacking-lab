# Lab 04 – TCP attacks and session hijacking

## Objectives

- Review the TCP three‑way handshake and connection teardown.
- Conduct SYN flood, TCP reset and session hijacking attacks.
- Perform the Mitnick attack: hijack a trusted connection by predicting sequence numbers:contentReference[oaicite:7]{index=7}.
- Apply defences such as SYN cookies, randomised initial sequence numbers (ISNs) and encrypted protocols.

## Background

TCP is a stateful protocol that uses sequence and acknowledgement numbers to ensure reliable delivery.  An attacker can exploit weaknesses in connection establishment and teardown:

- **SYN flood** – send a flood of SYN packets to exhaust the server’s backlog.
- **TCP reset** – send a forged RST packet with the correct sequence/ack numbers to tear down a connection.
- **Session hijacking** – predict or sniff sequence numbers to insert malicious data into an existing connection.  The famous Mitnick attack exploited predictable ISNs to gain root access to a target:contentReference[oaicite:8]{index=8}.

## Tasks

1. **SYN flood**  
   - In the `attacker` container, install `hping3` (`apt install -y hping3`).  
   - Start the FTP or web service in the DMZ and observe normal connections (`netstat -antp`).  
   - Run `hping3 -S -p 80 --flood 192.168.30.10` to flood the web server with SYN packets.  Monitor the server’s connection table (`ss -nt state SYN-RECV`) and CPU usage.  
   - Apply SYN cookies on the server (`sysctl -w net.ipv4.tcp_syncookies=1`) and repeat the attack.  Observe the difference.

2. **TCP reset**  
   - Establish a persistent connection from the client to the DMZ web server (e.g. `curl http://192.168.30.10/`).  
   - Use `tcpdump` to capture the sequence and acknowledgment numbers.  
   - Craft a RST packet using `scapy` or `hping3` with the correct sequence and send it to the server.  Verify that the connection is closed.

3. **Session hijacking (Mitnick attack)**  
   - Set up a trust relationship: run an outdated `rsh` or `rlogin` server in the DMZ that trusts the client’s IP.  
   - Use `nmap --data-length` and Scapy to predict the server’s ISNs by measuring increments between sequence numbers.  
   - Forge a new connection with predicted ISNs, send commands to create a backdoor user, and reset the legitimate connection.  
   - Patch the server to use randomised ISNs and disable insecure services like `rsh`.  Repeat the attack to see if it still works.

4. **Defences**  
   - Enable SYN cookies (`/etc/sysctl.conf`), random ISNs, and TCP timestamps to make prediction harder.  
   - Replace insecure services with SSH.  
   - Use a firewall or intrusion detection system to detect and block floods and suspicious sequence patterns.

Proceed to [Lab 05 – DNS attacks](05-dns-attacks.md).
