resource "incus_network_acl" "base" {
  name        = "base-acl"
  description = "Base ACL rules: DHCP, NTP y DNS are veryyyy strict "

  egress = [
    # 1. DHCP: Allow instances to request network configuration (Client -> Server)
    {
      action           = "allow"
      protocol         = "udp"
      destination_port = "67"
      description      = "Allow DHCP Request"
      state            = "enabled"
    },
    # 2. DNS: Allow DNS queries only to homelab DNS
    {
      action           = "allow"
      protocol         = "udp"
      destination      = var.dns_server_internal_ip
      destination_port = "53"
      description      = "Allow Internal DNS (UDP)"
      state            = "enabled"
    },
    # 3. DNS: Allow DNS queries only to homelab DNS (TCP)
    {
      action           = "allow"
      protocol         = "tcp"
      destination      = var.dns_server_internal_ip
      destination_port = "53"
      description      = "Allow Internal DNS (TCP)"
      state            = "enabled"
    },
    # 4. DNS: Block DNS requests to external servers
    {
      action           = "drop"
      protocol         = "udp"
      destination_port = "53"
      description      = "Block Rogue DNS (UDP)"
      state            = "enabled"
    },
    {
      action           = "drop"
      protocol         = "tcp"
      destination_port = "53"
      description      = "Block Rogue DNS (TCP)"
      state            = "enabled"
    },
    # 5. NTP: Allow time to be synced (TODO: Host my own NTP server)
    {
      action           = "allow"
      protocol         = "udp"
      destination_port = "123"
      description      = "Allow NTP"
      state            = "enabled"
    },
    # 6. ICMP: Block outgonig ICMP so that my machines don't ping random stuff
    {
      action      = "drop"
      protocol    = "icmp4"
      description = "Block Outbound Ping"
      state       = "enabled"
    }
  ]

  ingress = [
    # 1. DHCP: Allow instances to receive network configuration (Server -> Client)
    {
      action           = "allow"
      protocol         = "udp"
      destination_port = "68"
      description      = "Allow DHCP Offer"
      state            = "enabled"
    },
    # 2. DHCP: Don't allow some weirdo instance to become a DHCP server
    {
      action           = "drop"
      protocol         = "udp"
      destination_port = "67"
      description      = "Block Rogue DHCP Server"
      state            = "enabled"
    },
    # 3. ICMP: Allow receiving ping only from management subnet
    {
      action      = "allow"
      protocol    = "icmp4"
      source      = var.network_management_cidr
      description = "Allow Ping from Management"
      state       = "enabled"
    }
  ]
}
