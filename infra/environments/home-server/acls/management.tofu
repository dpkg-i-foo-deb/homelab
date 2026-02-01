resource "incus_network_acl" "management_ingress" {
  name        = "management-ingress-acl"
  description = "Allow incoming SSH only from the management subnet"

  ingress = [
    {
      action           = "allow"
      protocol         = "tcp"
      destination_port = "22"
      source           = var.network_management_cidr
      description      = "Allow SSH from Management network"
      state            = "enabled"
    },
    # 2. Drop SSH connections that come from any other machine
    {
      action           = "drop"
      protocol         = "tcp"
      destination_port = "22"
      description      = "Drop SSH"
      state            = "enabled"
    }
  ]
}
