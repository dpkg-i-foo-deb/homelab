resource "incus_network_acl" "web_client" {
  name        = "web-client-acl"
  description = "Don't fucking touch my private network"

  egress = [
    # Instances are not allowed to request anything on the private network
    {
      action      = "drop"
      destination = var.homelab_cidr
      description = "Block Access to LAN"
      state       = "enabled"
    },
    # Allow instances to perform normal web browsing
    {
      action           = "allow"
      protocol         = "tcp"
      destination_port = "80"
      description      = "Allow HTTP (TCP)"
      state            = "enabled"
    },
    {
      action           = "allow"
      protocol         = "tcp"
      destination_port = "443"
      description      = "Allow HTTPS (TCP)"
      state            = "enabled"
    },
    {
      action           = "allow"
      protocol         = "udp"
      destination_port = "443"
      description      = "Allow HTTP/3 QUIC (UDP)"
      state            = "enabled"
    }
  ]
}
