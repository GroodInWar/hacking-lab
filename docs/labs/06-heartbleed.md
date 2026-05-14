# Lab 06 – Heartbleed and protocol flaws

## Objectives

- Understand the OpenSSL Heartbleed vulnerability (CVE‑2014‑0160).
- Exploit Heartbleed to leak sensitive data from memory.
- Patch the vulnerable service and verify the fix.
- Discuss the importance of input length validation and timely patching.

## Background

Heartbleed is a bug in the TLS heartbeat extension of OpenSSL.  A client could send a heartbeat request with a small payload but a large claimed length; the server would respond with the claimed length of data, leaking whatever followed in memory:contentReference[oaicite:10]{index=10}.  This allowed attackers to steal private keys, passwords and other sensitive information.

## Tasks

1. **Build a vulnerable server**  
   - Create a new service container based on Ubuntu 12.04 with OpenSSL 1.0.1 vulnerable to Heartbleed.  Compile and run a simple HTTPS server (e.g. `openssl s_server`).  
   - Add this container to the DMZ network in `docker/docker-compose.override.yml`.

2. **Exploit Heartbleed**  
   - From the `attacker` container, use the `heartleech.py` script from the SEED lab or write your own using Python’s `socket` library.  Send a malicious heartbeat request to the vulnerable server.  
   - Observe the leaked memory; look for strings such as private keys, passwords or HTTP headers.

3. **Patch and verify**  
   - Update OpenSSL in the vulnerable container to a fixed version (`apt update && apt install openssl=1.0.1g`).  
   - Repeat the attack; the server should now respond with only the heartbeat payload.  
   - Discuss why input length validation is crucial in protocol implementations.

4. **Discussion**  
   - What other protocol extensions have led to similar vulnerabilities?  
   - How can organisations ensure timely patching of critical libraries?  
   - Why is it dangerous to allow arbitrary input lengths without validation?

Proceed to [Lab 07 – Firewalls and evasion](07-firewalls.md).
