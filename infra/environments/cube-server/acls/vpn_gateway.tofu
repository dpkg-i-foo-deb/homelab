resource "incus_network_acl" "vpn_gateway" {
  name        = "vpn-gateway-acl"
  description = "Allow connecting to Wireguard only if it is my VPS"

  egress = [
    {
      action      = "allow"
      protocol    = "udp"
      destination = var.vps_public_ip
      description = "Allow WireGuard Tunnel to VPS"
      state       = "enabled"
    },
    # Routing: Allow forwarding packets to the public internet
    {
      action      = "allow"
      description = "Allow Routing Egress"
      state       = "enabled"
    }
  ]

  ingress = [
    # Allow routing LAN packets
    {
      action      = "allow"
      source      = var.homelab_cidr
      description = "Allow LAN Routing Ingress"
      state       = "enabled"
    }
  ]
}
