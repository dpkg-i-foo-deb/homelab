resource "incus_storage_volume" "servarr_data" {
  name = "servarr_data"
  pool = var.virt_main_pool
  config = {
    "size" = "30GiB"
  }
}

resource "incus_storage_volume" "servarr_cache" {
  name = "servarr_cache"
  pool = var.virt_high_io_pool
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
      parent         = var.trusted_net
      "ipv4.address" = "10.0.0.12"
      mtu            = "9000"
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
      source = incus_storage_volume.servarr_data.name
      pool   = var.virt_main_pool
    }
  }

  device {
    name = "cache"
    type = "disk"
    properties = {
      path   = "/tmp/servarr-cache"
      source = incus_storage_volume.servarr_cache.name
      pool   = var.virt_spin_usb_pool
    }
  }

  device {
    name = "downloads"
    type = "disk"
    properties = {
      path   = "/downloads"
      source = var.downloads_vol
      pool   = var.virt_spin_usb_pool
    }
  }

  device {
    name = "music"
    type = "disk"
    properties = {
      path   = "/music"
      source = var.music_vol
      pool   = var.virt_spin_usb_pool
    }

  }
}
