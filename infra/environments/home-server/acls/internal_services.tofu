resource "incus_network_acl" "internal_services_client" {
  name        = "internal-services-client-acl"
  description = "Allow web browsing to internal services"
  egress = [ # Web browsing on reverse proxy is fine (No SSH allowed ofc)
    {
      action           = "allow"
      destination      = var.network_reverse_proxy_cidr
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = var.network_reverse_proxy_cidr
      destination_port = "443"
      protocol         = "udp"
      state            = "enabled"
    },
  ]
  ingress = []
}
