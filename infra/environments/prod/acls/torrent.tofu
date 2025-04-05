resource "incus_network_acl" "torrenting_inbound" {
  name = "torrenting-inbound"

  ingress = [

    {
      action           = "allow"
      source           = "@external"
      destination_port = "6881"
      protocol         = "udp"
      description      = "Allow connections for torrenting (UDP)"
      state            = "enabled"
    },
  ]

  egress = [
    {
      action           = "allow"
      destination      = "@external"
      destination_port = "6881-6889"
      protocol         = "udp"
      description      = "Allow outbound connections for torrenting using standard ports (UDP)"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "@external"
      destination_port = "6969,1337"
      protocol         = "udp"
      description      = "Allow outbound connections for torrenting using non-standard ports (UDP)"
      state            = "enabled"
    }
  ]
}
