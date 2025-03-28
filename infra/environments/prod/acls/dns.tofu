resource "incus_network_acl" "external_dns" {
  name = "external-dns"

  egress = [
    {
      action           = "allow"
      destination      = "1.1.1.1,1.0.0.1"
      destination_port = "53"
      protocol         = "udp"
      description      = "Allow DNS to Cloudflare public resolvers (UDP)"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "1.1.1.1,1.0.0.1"
      destination_port = "53"
      protocol         = "tcp"
      description      = "Allow DNS to Cloudflare public resolvers (TCP)"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = var.allowed_dns_subnets
      destination_port = "53"
      protocol         = "tcp"
      description      = "Allow DNS to other Cloudflare public resolvers (TCP)"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = var.allowed_dns_subnets
      destination_port = "53"
      protocol         = "udp"
      description      = "Allow DNS to other Cloudflare public resolvers (UDP)"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "8.8.8.8"
      destination_port = "53"
      protocol         = "udp"
      description      = "Allow DNS to Google public resolvers (UDP)"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "8.8.8.8"
      destination_port = "53"
      protocol         = "tcp"
      description      = "Allow DNS to Google public resolvers (TCP)"
      state            = "enabled"
    },
  ]
}

resource "incus_network_acl" "internal_dns" {
  name = "internal-dns"

  egress = [
    {
      action           = "allow"
      destination      = "10.0.2.2,10.0.2.3"
      destination_port = "53"
      protocol         = "udp"
      description      = "Allow DNS to internal servers (UDP)"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "10.0.2.2,10.0.2.3"
      destination_port = "53"
      protocol         = "tcp"
      description      = "Allow DNS to internal servers (TCP)"
      state            = "enabled"
    }
  ]
}

resource "incus_network_acl" "inbound_dns" {
  name = "inbound-dns"

  ingress = [
    {
      action           = "allow"
      source           = "@external"
      destination_port = "53"
      protocol         = "udp"
      description      = "Allow incoming DNS connections (UDP)"
      state            = "enabled"
    },
    {
      action           = "allow"
      source           = "@external"
      destination_port = "53"
      protocol         = "tcp"
      description      = "Allow incoming DNS connections (TCP)"
      state            = "enabled"
    }
  ]
}

