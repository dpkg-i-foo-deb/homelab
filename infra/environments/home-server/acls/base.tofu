resource "incus_network_acl" "base" {
  name        = "base-acl"
  description = "Base ACL rules: DHCP, NTP y DNS are veryyyy strict "

  egress = [
    # Allow instances to request network configuration (Client -> Server)
    {
      action           = "allow"
      protocol         = "udp"
      destination_port = "67"
      description      = "Allow DHCP Request"
      state            = "enabled"
    },
    # Allow DNS queries only to homelab DNS
    {
      action           = "allow"
      protocol         = "udp"
      destination      = var.dns_server_internal_ip
      destination_port = "53"
      description      = "Allow Internal DNS (UDP)"
      state            = "enabled"
    },
    # Allow DNS queries only to homelab DNS (TCP)
    {
      action           = "allow"
      protocol         = "tcp"
      destination      = var.dns_server_internal_ip
      destination_port = "53"
      description      = "Allow Internal DNS (TCP)"
      state            = "enabled"
    },
    # Allow time to be synced (TODO: Host my own NTP server)
    {
      action           = "allow"
      protocol         = "udp"
      destination_port = "123"
      description      = "Allow NTP"
      state            = "enabled"
    },
  ]
}
