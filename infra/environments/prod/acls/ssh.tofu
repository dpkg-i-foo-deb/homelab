resource "incus_network_acl" "ssh_mgmt" {
  name = "ssh-mgmt"

  ingress = [
    {
      action           = "allow"
      source           = var.mgmt_subnet
      destination_port = "22"
      protocol         = "tcp"
      description      = "Allow incoming management SSH connections"
      state            = "logged"
    }
  ]
}

resource "incus_network_acl" "ssh_outbound" {
  name = "ssh-outbound"

  egress = [
    {
      action           = "allow"
      destination      = var.allowed_ssh_subnets
      destination_port = "22"
      protocol         = "tcp"
      description      = "Allow outbound SSH to specified subnets"
      state            = "logged"
    },
  ]
}
