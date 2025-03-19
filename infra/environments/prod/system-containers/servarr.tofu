resource "incus_storage_volume" "servarr_data" {
  name = "servarr_data"
  pool = module.storage-pools.virt_main
  config = {
    "size" = "30GiB"
  }
}

resource "incus_storage_volume" "servarr_cache" {
  name = "servarr_cache"
  pool = module.storage-pools.virt_high_io
  config = {
    "size" = "20GiB"
  }
}

resource "incus_instance" "servarr" {
  name  = "servarr"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.memory"               = "8GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.module}/cloud-init/servarr.yml.tftpl",
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
      parent         = module.network.trusted
      "ipv4.address" = "10.0.0.12"
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
      source = incus_storage_volume.servarr_data.name
      pool   = module.storage-pools.virt_main
    }
  }

  device {
    name = "cache"
    type = "disk"
    properties = {
      path   = "/tmp/servarr-cache"
      source = incus_storage_volume.servarr_cache.name
      pool   = module.storage-pools.virt_spin_usb
    }
  }

  device {
    name = "downloads"
    type = "disk"
    properties = {
      path   = "/downloads"
      source = module.storage-volumes.downloads
      pool   = module.storage-pools.virt_spin_usb
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
