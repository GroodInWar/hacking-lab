# Enterprise Network Security Lab

This repository contains a hands-on lab designed to teach students how to secure a vulnerable enterprise network through a series of progressively challenging exercises. The lab environment is built with Docker and includes an attacker, a client, three routers, DMZ services, and internal enterprise hosts.

## Getting started

1. **Install prerequisites** - Ensure you have Docker and Docker Compose installed on your machine.
2. **Clone this repository** - `git clone https://github.com/groodinwar/hacking-lab.git` and `cd hacking-lab`.
3. **Build the environment** - Navigate to the `docker/` directory and run `docker compose up -d`. This command will build a custom router image and start all containers in the topology.
4. **View the documentation** - The full write-up for each lab is located in the `docs/` folder. When this repository is published with GitHub Pages, the site will be available at `https://groodinwar.github.io/hacking-lab/`. You can also browse the Markdown files directly.

## Repository structure

- `docs/` - Markdown files for the GitHub Pages site. The landing page (`docs/index.md`) describes the overall lab and links to each exercise. Each lab is stored under `docs/labs/`.
- `docs/assets/` - Images and diagrams used in the documentation. The network topology diagram lives here.
- `docker/` - Docker Compose file and custom router image used to build the lab environment.
- `.github/workflows/` - GitHub Actions workflow that builds the Markdown documentation with Jekyll and deploys it to GitHub Pages.

## Topology

The lab uses four Docker bridge networks:

- `external` (`10.0.0.0/24`) - attacker, client, and `edge_router`.
- `transit` (`172.16.0.0/30`) - point-to-point link between `edge_router` and `core_router`.
- `dmz` (`192.168.1.0/24`) - public-facing services and the link between `core_router` and `internal_router`.
- `internal` (`10.1.0.0/24`) - internal enterprise hosts behind `internal_router`.

The main containers are:

| Container | Role | IP address |
| --- | --- | --- |
| `attacker` | Attacker workstation | `10.0.0.10` |
| `client` | External client workstation | `10.0.0.20` |
| `edge_router` | External-to-transit router | `10.0.0.1`, `172.16.0.1` |
| `core_router` | Transit-to-DMZ router | `172.16.0.2`, `192.168.1.1` |
| `internal_router` | DMZ-to-internal router | `192.168.1.2`, `10.1.0.1` |
| `web_server` | DMZ web service | `192.168.1.10` |
| `mail_server` | DMZ mail service | `192.168.1.20` |
| `dns_server` | DMZ DNS service | `192.168.1.30` |
| `file_server` | Internal file host | `10.1.0.10` |
| `database_server` | Internal database host | `10.1.0.20` |
| `user_pc` | Internal user workstation | `10.1.0.100` |

## Why Docker?

The lab uses Docker bridge networks to simulate switched segments and Linux containers to simulate routers. User-defined bridge networks let containers on the same segment communicate directly, while the router containers forward traffic between segments using static routes.

For details on the topology and services included in this lab, see `docs/index.md` and `docker/docker-compose.yml`.
