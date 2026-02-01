resource "incus_network_acl" "reverse_proxy" {
  name        = "reverse-proxy-acl"
  description = "Allow connecting TCP to everywhere but don't allow SSH to homelab network"

  egress = [
    {
      action           = "drop"
      protocol         = "tcp"
      destination      = var.homelab_cidr
      destination_port = "22"
      description      = "Block Lateral SSH Movement"
      state            = "enabled"
    },
    {
      action      = "allow"
      protocol    = "tcp"
      destination = var.homelab_cidr
      description = "Allow TCP to Internal Services"
      state       = "enabled"
    },
    {
      action           = "allow"
      protocol         = "tcp"
      destination_port = "80"
      description      = "Allow HTTP"
      state            = "enabled"
    },
    {
      action           = "allow"
      protocol         = "tcp"
      destination_port = "443"
      description      = "Allow HTTPS"
      state            = "enabled"
    }
  ]
}
