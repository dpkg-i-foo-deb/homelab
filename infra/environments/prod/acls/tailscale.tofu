# ALCs to allow Tailscale to establish
# direct connections
resource "incus_network_acl" "tailscale_inbound" {
  name = "tailscale-inbound"

  ingress = [
    {
      action           = "allow"
      source           = ""
      destination_port = "41641"
      protocol         = "udp"
      description      = "Allow incoming peer-to-peer connections for Tailscale"
      state            = "enabled"
    }
  ]

  egress = [
    {
      action           = "allow"
      destination      = ""
      destination_port = "3478"
      protocol         = "udp"
      description      = "Allow outgoing connections for the STUN protocol"
      state            = "enabled"
    },
    {
      source_port      = "41641"
      action           = "allow"
      destination      = ""
      destination_port = ""
      protocol         = "udp"
      description      = "Allow outgoing peer-to-peer connections for Tailscale"
      state            = "enabled"
    }
  ]
}
