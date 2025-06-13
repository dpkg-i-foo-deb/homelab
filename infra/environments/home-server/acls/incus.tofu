resource "incus_network_acl" "incus_api_outbound" {
  name = "incus-api-outbound"

  egress = [
    {
      action           = "allow"
      source           = ""
      destination      = var.incus_addresses
      destination_port = "8443"
      protocol         = "tcp"
      description      = "Allow traffic to the incus API (TCP)"
      state            = "enabled"
    },
    {
      action           = "allow"
      source           = ""
      destination      = var.incus_addresses
      destination_port = "8443"
      protocol         = "udp"
      description      = "Allow traffic to the incus API (UDP)"
      state            = "enabled"
    },
  ]
}
