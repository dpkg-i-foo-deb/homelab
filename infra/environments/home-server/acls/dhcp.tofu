resource "incus_network_acl" "dchp_outbound" {
  name = "dhcp-outbound"

  egress = [
    {
      action           = "allow"
      destination      = ""
      destination_port = "67"
      protocol         = "udp"
      description      = "Allow outgoing DHCP connections (UDP)"
      state            = "enabled"
    }
  ]

  ingress = [
    {
      action           = "allow"
      destination_port = "67"
      protocol         = "udp"
      description      = "Allow incoming DHCP connections (UDP)"
      state            = "enabled"
    }
  ]
}
