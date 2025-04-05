resource "incus_network_acl" "torrenting_inbound" {
  name = "torrenting-inbound"

  ingress = [
    {
      action           = "allow"
      source           = "@external"
      destination_port = "6881"
      protocol         = "tcp"
      description      = "Allow connections for torrenting (TCP)"
      state            = "enabled"
    },
    {
      action           = "allow"
      source           = "@external"
      destination_port = "6881"
      protocol         = "udp"
      description      = "Allow connections for torrenting (UDP)"
      state            = "enabled"
    },
  ]
}
