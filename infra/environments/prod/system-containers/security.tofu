resource "incus_storage_volume" "security_data" {
  name = "security_data"
  pool = module.storage-pools.virt_main
  config = {
    "size" = "50GiB"
  }
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
      "${path.module}/cloud-init/security.yml.tftpl",
      {
        ssh_public_key    = var.ssh_public_key,
        lxc_user_password = var.lxc_user_password,
        ansible_password  = var.ansible_password
      }
    )
    "security.nesting" = true
  }

  device {
    name = "eth0"
    type = "nic"
    properties = {
      nictype        = "bridged"
      parent         = module.networks.trusted
      "ipv4.address" = "10.0.0.11"
      mtu            = "9000"
    }
  }
  device {
    name = "root"
    type = "disk"
    properties = {
      path = "/"
      pool = module.storage-pools.virt_main
    }
  }

  device {
    name = "data"
    type = "disk"
    properties = {
      path   = "/home"
      source = incus_storage_volume.security_data.name
      pool   = module.storage-pools.virt_main
    }
  }

}
