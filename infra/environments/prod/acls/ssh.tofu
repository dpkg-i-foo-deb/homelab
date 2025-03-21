resource "incus_network_acl" "ssh_mgmt" {
  name = "ssh-mgmt"

  ingress = [
    {
      action           = "allow"
      source           = "@external"
      destination_port = "22"
      protocol         = "tcp"
      description      = "Allow incoming SSH connections"
      state            = "logged"
    }
  ]
}
