resource "incus_storage_volume" "reverse_proxy_data" {
  name    = "reverse_proxy_data"
  pool    = var.virt_main_pool
  project = "default"
}
resource "incus_network_acl" "reverse_proxy_outbound" {
  name = "reverse-proxy-outbound"

  # Allow connections to any port (So that we can access services)
  # Those connections are only on local networks

  egress = [
    {
      action           = "reject"
      destination      = ""
      destination_port = "22"
      protocol         = "tcp"
      description      = "Deny outbound SSH connections"
      state            = "enabled"
    },
    {
      action = "allow"
      destination = join(",",
        [
          var.dns_net.config["ipv4.address"],
          var.code_net.config["ipv4.address"],
          var.privileged_net.config["ipv4.address"],
          var.storage_net.config["ipv4.address"],
          var.torrenting_net.config["ipv4.address"],
          var.trusted_net.config["ipv4.address"],
          var.untrusted_net.config["ipv4.address"],
          var.monitoring_net.config["ipv4.address"],
          var.management_net.config["ipv4.address"]
      ])
      destination_port = ""
      protocol         = "tcp"
      description      = "Allow outbound connections to any port (TCP)"
      state            = "enabled"
    },
    {
      action = "allow"
      destination = join(",",
        [
          var.dns_net.config["ipv4.address"],
          var.code_net.config["ipv4.address"],
          var.privileged_net.config["ipv4.address"],
          var.storage_net.config["ipv4.address"],
          var.torrenting_net.config["ipv4.address"],
          var.trusted_net.config["ipv4.address"],
          var.monitoring_net.config["ipv4.address"],
          var.untrusted_net.config["ipv4.address"],
      ])
      destination_port = ""
      protocol         = "udp"
      description      = "Allow outbound connections to any port (UDP)"
      state            = "enabled"
    },
  ]
}

resource "incus_instance" "reverse_proxy" {
  name  = "reverse-proxy"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 2
    "limits.memory"               = "2GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.module}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key
        lxc_username             = "reverse-proxy"
        lxc_username_description = "Reverse proxy Linux System Container"
        lxc_user_password        = var.lxc_user_password
        ansible_password         = var.ansible_password
      }
    )
    "security.nesting" = true
  }

  device {
    name = "eth0"
    type = "nic"
    properties = {
      network        = var.reverse_proxy_net.name
      "ipv4.address" = "10.0.5.10"
      "security.acls" = join(",",
        [
          incus_network_acl.reverse_proxy_outbound.name
      ])
    }
  }

  device {
    name = "root"
    type = "disk"
    properties = {
      path = "/"
      pool = var.virt_main_pool
    }
  }

  device {
    name = "data"
    type = "disk"
    properties = {
      path   = "/home"
      source = incus_storage_volume.reverse_proxy_data.name
      pool   = var.virt_main_pool
    }
  }
}



