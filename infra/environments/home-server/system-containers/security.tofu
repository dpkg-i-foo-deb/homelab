resource "incus_storage_volume" "security_data" {
  name    = "security_data"
  pool    = var.virt_main_pool
  project = "default"
  config = {
    "size" = "50GiB"
  }
}

resource "incus_instance" "security" {
  name  = "security"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart" = true
    "limits.cpu"     = 2
    # "limits.cpu.allowance"        = "50%"
    "limits.memory"               = "16GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
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
      network                   = var.trusted_net.name
      "ipv4.address"            = "10.0.0.11"
      "security.ipv4_filtering" = true
      "security.ipv6_filtering" = true
      "security.mac_filtering"  = true
      "security.port_isolation" = true
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
