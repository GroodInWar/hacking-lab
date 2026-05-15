# Lab 08 – VPN tunnelling

## Objectives

- Understand how virtual private networks (VPNs) create secure tunnels through untrusted networks.
- Build a simple VPN using TUN/TAP devices and static keys.
- Use the VPN to bypass firewall restrictions.
- Extend the VPN to use TLS/SSL for encryption and authentication.

## Background

A VPN encapsulates IP packets inside another protocol to provide confidentiality, integrity and (optionally) authentication.  In a point‑to‑point VPN, two peers create virtual network interfaces (TUN or TAP) and exchange encrypted packets.  This lab focuses on building a rudimentary VPN to understand the mechanics; production VPNs use protocols like IPsec or OpenVPN.

## Tasks

1. **Set up a TUN/TAP interface**  
   - In the `attacker` container, load the `tun` module if necessary (`modprobe tun`).  
   - Create a TUN interface (`ip tuntap add dev tun0 mode tun`).  
   - Assign IP addresses (`ip addr add 10.8.0.1/24 dev tun0`) and bring it up (`ip link set tun0 up`).

2. **Write a simple VPN program**  
   - Using Python or C, write two programs: a **server** running on the DMZ web server and a **client** running on the attacker.  Each program should read packets from the TUN interface, encapsulate them (e.g. prefix with a length field), send over a TCP/UDP socket, receive encapsulated packets, and write them to the TUN interface.  
   - Assign IP `10.8.0.2/24` to the server’s TUN interface.

3. **Route traffic through the VPN**  
   - On the attacker, add a route for the internal network (`10.1.0.0/24`) via `10.8.0.2`.  
   - On the server, add a route for the external network (`10.0.0.0/24`) via `10.8.0.1`.  
   - Test connectivity: ping internal hosts through the VPN.  The firewall should not see the encapsulated traffic’s inner headers.

4. **Encrypt and authenticate**  
   - Modify your VPN program to wrap packets in TLS.  Use Python’s `ssl` module or OpenSSL to perform a TLS handshake and then exchange data.  
   - Generate a self‑signed certificate for the server and configure the client to trust it.  
   - Verify that packet contents are encrypted when captured on the wire.

5. **Discussion**  
   - How does a TUN device differ from a TAP device?  
   - What are the advantages and disadvantages of building your own VPN compared with using OpenVPN or WireGuard?  
   - How can certificate authorities and mutual authentication be used to prevent man‑in‑the‑middle attacks?

Proceed to [Lab 09 – Network hardening and monitoring](09-hardening.html).
