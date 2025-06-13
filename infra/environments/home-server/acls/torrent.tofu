resource "incus_network_acl" "torrenting" {
  name = "torrenting"

  ingress = [

    {
      action           = "allow"
      source           = "@external"
      destination_port = "6881"
      protocol         = "udp"
      description      = "Allow incoming connections for torrenting (UDP)"
      state            = "enabled"
    },
  ]

  egress = [
    {
      action           = "reject"
      destination      = "@external"
      destination_port = "22"
      protocol         = "tcp"
      description      = "Don't allow connections to SSH"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "@external"
      destination_port = ""
      protocol         = "udp"
      description      = "Allow any connection anywhere since trackers use a  lot of exotic ports (UDP)"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "@external"
      destination_port = ""
      protocol         = "tcp"
      description      = "Allow any connection anywhere since trackers use a  lot of exotic ports (TCP)"
      state            = "enabled"
    },
  ]
}
