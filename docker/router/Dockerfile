FROM debian:stable-slim

# Install networking utilities.  iproute2 provides the `ip` command
# for configuring addresses and routes, and iptables/nftables for
# optional packet filtering or NAT.  We also install bash to make
# scripting easier.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        iproute2 iptables bash && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy the entrypoint script into the image and make it executable.
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Use the custom entrypoint.  The script will set up interface
# addresses, enable IP forwarding and configure static routes.  The
# default command simply sleeps forever so the container stays alive.
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["sleep", "infinity"]