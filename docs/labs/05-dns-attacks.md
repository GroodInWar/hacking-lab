# Lab 05 – DNS attacks

## Objectives

- Understand how the Domain Name System (DNS) resolves names to IP addresses.
- Perform local DNS cache poisoning and pharming attacks.
- Carry out Kaminsky‑style remote DNS cache poisoning.
- Explore DNS rebinding to bypass the browser’s same‑origin policy.

## Background

DNS is a hierarchical, distributed database.  Hosts typically query a local resolver, which caches answers.  Attackers can spoof DNS responses to poison caches or trick victims into connecting to malicious IPs.  The SEED DNS labs cover attacks such as local DNS poisoning, remote DNS cache poisoning and DNS rebinding.

## Tasks

1. **Local DNS poisoning (pharming)**  
   - Use the DMZ DNS server (`dns_server`, `192.168.1.30`) or replace it with a custom `bind9`/`dnsmasq` configuration that serves the zone `seedlab.test`.  
   - Configure the client’s `/etc/resolv.conf` to use `192.168.1.30`.  
   - From the attacker, send a spoofed DNS reply for `www.seedlab.test` pointing to `10.0.0.10` (the attacker).  Use tools like `scapy` or `dsniff`.  
   - On the client, verify that `ping www.seedlab.test` resolves to the attacker's IP and that HTTP connections are redirected.

2. **Remote cache poisoning (Kaminsky attack)**  
   - Configure `dns_server` to forward queries for unknown domains to a public resolver.  
   - From the attacker, send a flood of spoofed DNS responses with random transaction IDs to the DNS server for a domain that has not been queried yet.  
   - If successful, the DNS server will cache your malicious record.  Repeat the attack with and without query‑ID randomisation on the server.

3. **DNS rebinding**  
   - Build a simple HTTP server on the attacker that serves a web page with JavaScript. The page instructs the browser to connect back to `seedlab-iot.test` hosted on an internal host, such as `file_server` (`10.1.0.10`) behind `internal_router`.  
   - Register two DNS records for the same domain: one pointing to the attacker’s IP with a short TTL, and another to the internal host.  
   - Instruct the client’s browser to visit the attacker’s page.  When the TTL expires, the domain resolves to the internal IP and the browser’s same‑origin policy is bypassed.  Access the IoT API as the attacker.

4. **Defences**  
   - Enable source port and transaction ID randomisation on DNS servers.  
   - Deploy DNSSEC to authenticate DNS responses.  
   - Configure browsers or OS to block DNS rebinding by preventing private IP addresses in DNS responses.

Proceed to [Lab 06 – Heartbleed and protocol flaws](06-heartbleed.html).
