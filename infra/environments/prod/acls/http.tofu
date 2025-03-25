resource "incus_network_acl" "http" {
  name = "http"

  egress = [
    {
      action           = "allow"
      destination      = ""
      destination_port = "80"
      protocol         = "tcp"
      description      = "Allow http traffic"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = ""
      destination_port = "443"
      protocol         = "tcp"
      description      = "Allow https traffic (TCP)"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = ""
      destination_port = "443"
      protocol         = "udp"
      description      = "Allow https traffic (UDP)"
      state            = "enabled"
    },
  ]
}

resource "incus_network_acl" "http_inbound" {
  name = "http-inbound"

  ingress = [
    {
      action           = "allow"
      source           = "@external"
      destination_port = "80,443"
      protocol         = "tcp"
      description      = "Allow incoming HTTP connections (TCP)"
      state            = "enabled"
    },
    {
      action           = "allow"
      source           = "@external"
      destination_port = "80,443"
      protocol         = "tcp"
      description      = "Allow incoming HTTP connections (UDP)"
      state            = "enabled"
    }
  ]
}
