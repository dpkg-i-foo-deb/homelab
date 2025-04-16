# ALCs to allow Tailscale to establish
# direct connections
resource "incus_network_acl" "tailscale_inbound" {
  name = "tailscale-inbound"

  ingress = [
    {
      action           = "allow"
      source           = "@external"
      destination_port = "41641"
      protocol         = "udp"
      description      = "Allow peer-to-peer connections for Tailscale"
      state            = "enabled"
    },
    {
      action           = "allow"
      source           = "@external"
      destination_port = "3478"
      protocol         = "udp"
      description      = "Allow incoming connections for the STUN protocol"
      state            = "enabled"
    }
  ]

  egress = [
    {
      action           = "allow"
      destination      = "@external"
      destination_port = "3478"
      protocol         = "udp"
      description      = "Allow outgoing connections for the STUN protocol"
      state            = "enabled"
    }
  ]
}
