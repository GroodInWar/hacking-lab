# Enterprise Network Security Lab

This repository contains a hands‑on lab designed to teach students how to secure a vulnerable enterprise network through a series of progressively challenging exercises.  The lab environment is built with Docker and includes an attacker, a client, three routers, and segmented networks (LAN, DMZ and internal).

## Getting started

1. **Install prerequisites** – Ensure you have Docker and Docker Compose installed on your machine.
2. **Clone this repository** – `git clone https://github.com/groodinwar/enterprise-lab-site.git` and `cd enterprise-lab-site`.
3. **Build the environment** – Navigate to the `docker/` directory and run `docker compose up -d`.  This command will build a custom router image and start all containers in the topology.
4. **View the documentation** – The full write‑up for each lab is located in the `docs/` folder.  When this repository is published with GitHub Pages, the site will be available at `https://groodinwar.github.io/enterprise-lab-site/`.  You can also browse the markdown files directly.

## Repository structure

- `docs/` – Markdown files for the GitHub Pages site.  The landing page (`docs/index.md`) describes the overall lab and provides links to each exercise.  Each lab is stored under `docs/labs/`.
- `docs/assets/` – Images and diagrams used in the documentation.  The network topology diagram lives here.
- `docker/` – Docker Compose file and custom router image used to build the lab environment.
- `.github/workflows/` – GitHub Actions workflow that builds and deploys the static documentation site to GitHub Pages.
- `labs/` (virtual) – The labs themselves are contained in the `docs/labs/` folder; they are not separate repositories.

## Why Docker?

The lab uses Docker bridge networks to simulate switches and routers.  According to the Docker documentation, user‑defined networks created with the `bridge` driver are backed by Linux bridge devices, which act like software switches:contentReference[oaicite:0]{index=0}.  This allows us to model a LAN, DMZ and internal network with minimal overhead.

For details on the topology and services included in this lab, see `docs/index.md` and `docker/docker-compose.yml`.
