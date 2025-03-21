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
