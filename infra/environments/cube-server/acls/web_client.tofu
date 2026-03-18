resource "incus_network_acl" "web_client" {
  name        = "web-client-acl"
  description = "Don't fucking touch my private network"

  egress = [
    # 0.0.0.0 - 7.255.255.255
    {
      action           = "allow"
      destination      = "0.0.0.0/5"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "0.0.0.0/5"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 8.0.0.0 - 9.255.255.255
    {
      action           = "allow"
      destination      = "8.0.0.0/7"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "8.0.0.0/7"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 11.0.0.0 - 11.255.255.255
    {
      action           = "allow"
      destination      = "11.0.0.0/8"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "11.0.0.0/8"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 12.0.0.0 - 15.255.255.255
    {
      action           = "allow"
      destination      = "12.0.0.0/6"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "12.0.0.0/6"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 16.0.0.0 - 31.255.255.255
    {
      action           = "allow"
      destination      = "16.0.0.0/4"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "16.0.0.0/4"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 32.0.0.0 - 63.255.255.255
    {
      action           = "allow"
      destination      = "32.0.0.0/3"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "32.0.0.0/3"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 64.0.0.0 - 127.255.255.255
    {
      action           = "allow"
      destination      = "64.0.0.0/2"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "64.0.0.0/2"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 128.0.0.0 - 159.255.255.255
    {
      action           = "allow"
      destination      = "128.0.0.0/3"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "128.0.0.0/3"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 160.0.0.0 - 167.255.255.255
    {
      action           = "allow"
      destination      = "160.0.0.0/5"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "160.0.0.0/5"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 168.0.0.0 - 171.255.255.255
    {
      action           = "allow"
      destination      = "168.0.0.0/6"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "168.0.0.0/6"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 172.0.0.0 - 172.15.255.255
    {
      action           = "allow"
      destination      = "172.0.0.0/12"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "172.0.0.0/12"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 172.32.0.0 - 172.63.255.255
    {
      action           = "allow"
      destination      = "172.32.0.0/11"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "172.32.0.0/11"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 172.64.0.0 - 172.127.255.255
    {
      action           = "allow"
      destination      = "172.64.0.0/10"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "172.64.0.0/10"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 172.128.0.0 - 172.255.255.255
    {
      action           = "allow"
      destination      = "172.128.0.0/9"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "172.128.0.0/9"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 173.0.0.0 - 173.255.255.255
    {
      action           = "allow"
      destination      = "173.0.0.0/8"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "173.0.0.0/8"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 174.0.0.0 - 175.255.255.255
    {
      action           = "allow"
      destination      = "174.0.0.0/7"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "174.0.0.0/7"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 176.0.0.0 - 191.255.255.255
    {
      action           = "allow"
      destination      = "176.0.0.0/4"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "176.0.0.0/4"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 192.0.0.0 - 192.127.255.255
    {
      action           = "allow"
      destination      = "192.0.0.0/9"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "192.0.0.0/9"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 192.128.0.0 - 192.159.255.255
    {
      action           = "allow"
      destination      = "192.128.0.0/11"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "192.128.0.0/11"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 192.160.0.0 - 192.167.255.255
    {
      action           = "allow"
      destination      = "192.160.0.0/13"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "192.160.0.0/13"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 192.169.0.0 - 192.169.255.255
    {
      action           = "allow"
      destination      = "192.169.0.0/16"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "192.169.0.0/16"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 192.170.0.0 - 192.171.255.255
    {
      action           = "allow"
      destination      = "192.170.0.0/15"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "192.170.0.0/15"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 192.172.0.0 - 192.175.255.255
    {
      action           = "allow"
      destination      = "192.172.0.0/14"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "192.172.0.0/14"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 192.176.0.0 - 192.191.255.255
    {
      action           = "allow"
      destination      = "192.176.0.0/12"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "192.176.0.0/12"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 192.192.0.0 - 192.255.255.255
    {
      action           = "allow"
      destination      = "192.192.0.0/10"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "192.192.0.0/10"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 193.0.0.0 - 193.255.255.255
    {
      action           = "allow"
      destination      = "193.0.0.0/8"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "193.0.0.0/8"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 194.0.0.0 - 195.255.255.255
    {
      action           = "allow"
      destination      = "194.0.0.0/7"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "194.0.0.0/7"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 196.0.0.0 - 199.255.255.255
    {
      action           = "allow"
      destination      = "196.0.0.0/6"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "196.0.0.0/6"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 200.0.0.0 - 207.255.255.255
    {
      action           = "allow"
      destination      = "200.0.0.0/5"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "200.0.0.0/5"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    },

    # 208.0.0.0 - 223.255.255.255
    {
      action           = "allow"
      destination      = "208.0.0.0/4"
      protocol         = "tcp"
      destination_port = "80,443"
      state            = "enabled"
    },
    {
      action           = "allow"
      destination      = "208.0.0.0/4"
      protocol         = "udp"
      destination_port = "443"
      state            = "enabled"
    }
  ]
}
