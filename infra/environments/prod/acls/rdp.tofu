resource "incus_network_acl" "rdp_inbound" {
  name = "rdp-inbound"

  ingress = [
    {
      action           = "allow"
      source           = var.mgmt_subnets
      destination_port = "3389"
      protocol         = "tcp"
      description      = "Allow incoming RDP (TCP)"
      state            = "enabled"
    },
    {
      action           = "allow"
      source           = var.mgmt_subnets
      destination_port = "3389"
      protocol         = "udp"
      description      = "Allow incoming RDP connections (UDP)"
      state            = "enabled"
    }
  ]
}
