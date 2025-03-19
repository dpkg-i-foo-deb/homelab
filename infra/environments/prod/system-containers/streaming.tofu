resource "incus_storage_volume" "streaming_data" {
  name = "streaming_data"
  pool = module.storage-volumes.virt_main
}

resource "incus_instance" "streaming" {
  name  = "streaming"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.cpu.allowance"        = "20%"
    "limits.memory"               = "1GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.module}/cloud-init/streaming.yml.tftpl",
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
      "ipv4.address" = "10.0.0.13"
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
      source = incus_storage_volume.streaming_data.name
      pool   = module.storage-pools.virt_main
    }
  }

  device {
    name = "music"
    type = "disk"
    properties = {
      path   = "/music"
      source = module.storage-volumes.music
      pool   = module.storage-pools.virt_spin_usb
    }
  }
}
