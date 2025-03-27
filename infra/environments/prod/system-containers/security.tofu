resource "incus_storage_volume" "security_data" {
  name    = "security_data"
  pool    = var.virt_main_pool
  project = "default"
  config = {
    "size" = "50GiB"
  }
}

resource "incus_network_acl" "security_svc" {
  name = "security-svc"

  ingress = [
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "8080"
      protocol         = "tcp"
      description      = "Allow incoming connections to Vaultwarden"
      state            = "enabled"
    },
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "8081"
      protocol         = "tcp"
      description      = "Allow incoming connections to Keycloak"
      state            = "enabled"
    },
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "5601"
      protocol         = "tcp"
      description      = "Allow incoming connections to Wazuh dashboard"
      state            = "enabled"
    },
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "1514-1515"
      protocol         = "tcp"
      description      = "Allow incoming connections to Wazuh agent service"
      state            = "enabled"
    },
  ]
}

resource "incus_instance" "security" {
  name  = "security"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.cpu.allowance"        = "50%"
    "limits.memory"               = "8GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.module}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key,
        lxc_username             = "security"
        lxc_username_description = "Security Linux System Container"
        lxc_user_password        = var.lxc_user_password,
        ansible_password         = var.ansible_password
      }
    )
    "security.nesting" = true
  }

  device {
    name = "eth0"
    type = "nic"
    properties = {
      network        = var.trusted_net.name
      "ipv4.address" = "10.0.0.11"
      "security.acls" = join(",",
        [
          incus_network_acl.security_svc.name
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
      source = incus_storage_volume.security_data.name
      pool   = var.virt_main_pool
    }
  }

}
