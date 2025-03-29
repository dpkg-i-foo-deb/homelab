resource "incus_network_acl" "wazuh_security" {
  name = "wazuh-security"

   egress = [
    {
      action           = "allow"
      destination      = var.security_ip
      destination_port = "1514,1515"
      protocol         = "tcp"
      description      = "Allow connecting to the Wazuh server (TCP)"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = var.security_ip
      destination_port = "1514,1515"
      protocol         = "tcp"
      description      = "Allow connecting to the Wazuh server (UDP)"
      state            = "enabled"
    }
  ]
}

