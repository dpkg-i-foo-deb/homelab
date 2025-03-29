resource "incus_network_acl" "wazuh_security" {
  name = "wazuh-security"

  ingress = [
    {
      action           = "allow"
      source           = var.mgmt_subnet
      destination_port = "1514-1515"
      protocol         = "tcp"
      description      = "Allow connecting to the Wazuh server (TCP)"
      state            = "allowed"
    },
    {
      action           = "allow"
      source           = var.mgmt_subnet
      destination_port = "1514-1515"
      protocol         = "tcp"
      description      = "Allow connecting to the Wazuh server (UDP)"
      state            = "allowed"
    }
  ]
}

