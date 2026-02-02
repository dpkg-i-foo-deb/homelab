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
    {
      action      = "allow"
      protocol    = "icmp4"
      source      = var.network_management_cidr
      icmp_type   = "8"
      description = "Allow ICMP from management network"
      state       = "enabled"
    }
  ]
  # Allow replying SSH and ICMP only to management networks
  egress = [{
    action      = "allow"
    protocol    = "tcp"
    destination = var.network_management_cidr
    source_port = "22"
    description = "Allow SSH Replies to management network"
    state       = "disabled"
    }
    , {
      action      = "allow"
      protocol    = "icmp4"
      destination = var.network_management_cidr
      icmp_type   = "0"
      description = "Allow ICMP Replies to management network"
      state       = "disabled"
  }]
}
