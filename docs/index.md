# Enterprise Network Security Lab

Welcome to the enterprise network security lab. This lab starts with a vulnerable enterprise-style network and guides you through a series of attacks and defenses. By completing the exercises, you will learn networking fundamentals, how common attacks work, and how to harden a segmented environment.

![Network topology](assets/network-topology.png)

## Overview

The lab environment consists of four network segments:

- **External** (`10.0.0.0/24`) - attacker, client, and the outside interface of `edge_router`.
- **Transit** (`172.16.0.0/30`) - point-to-point routing segment between `edge_router` and `core_router`.
- **DMZ** (`192.168.1.0/24`) - public-facing services: `web_server`, `mail_server`, and `dns_server`.
- **Internal** (`10.1.0.0/24`) - protected enterprise hosts: `file_server`, `database_server`, and `user_pc`.

Traffic flows through `edge_router`, `core_router`, and `internal_router`, which are Linux containers configured with static routes. The default configuration is intentionally permissive so students can observe attacks before adding hardening controls.

## Labs

| Lab | Description |
| --- | --- |
| [00 - Basic networking and reconnaissance](labs/00-basic-networking.html) | Explore the network, understand IP addressing and routing, and learn to capture and spoof packets. |
| [01 - ARP poisoning and MITM](labs/01-arp-poisoning.html) | Perform ARP cache poisoning on the external segment, then implement defenses such as static ARP entries. |
| [02 - IP fragmentation & ICMP attacks](labs/02-ip-icmp-attacks.html) | Launch fragmentation and ICMP-based attacks, experiment with ICMP redirects, and enable reverse-path filtering. |
| [03 - UDP amplification attacks](labs/03-udp-amplification.html) | Use exposed UDP services such as DNS to amplify traffic and then implement rate limiting. |
| [04 - TCP attacks and session hijacking](labs/04-tcp-attacks.html) | Conduct SYN flooding, TCP reset and hijacking attacks, then apply countermeasures like SYN cookies. |
| [05 - DNS attacks](labs/05-dns-attacks.html) | Poison local DNS responses, perform cache-poisoning experiments, and learn about DNSSEC and rebinding defenses. |
| [06 - Heartbleed and protocol flaws](labs/06-heartbleed.html) | Exploit the Heartbleed vulnerability in a DMZ service, then patch OpenSSL and verify the fix. |
| [07 - Firewalls and evasion](labs/07-firewalls.html) | Build filtering rules between network segments and test evasion techniques. |
| [08 - VPN tunnelling](labs/08-vpn.html) | Create a TUN/TAP-based VPN from the external segment into the DMZ and route traffic to internal hosts. |
| [09 - Network hardening and monitoring](labs/09-hardening.html) | Combine previous defenses to harden the enterprise network with NAT, IDS/IPS, segmentation, and patching. |

Each lab includes learning objectives, background theory, step-by-step tasks, and discussion questions.

## Quick start

If you have not yet set up the lab environment, follow the instructions in `README.md` and `docker/docker-compose.yml` to build and start the network. Then work through the labs in order, referring back to this index as needed.

Good luck, and have fun learning about network security!
