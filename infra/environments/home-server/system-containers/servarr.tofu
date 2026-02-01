resource "incus_storage_volume" "servarr_data" {
  name    = "servarr_data"
  pool    = var.virt_main_pool
  project = "default"
  config = {
    "size" = "30GiB"
  }
}

resource "incus_storage_volume" "servarr_cache" {
  name    = "servarr-cache"
  pool    = var.virt_spin0_pool
  project = "default"
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
    "limits.cpu.allowance"        = "20%"
    "limits.memory"               = "12GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key,
        lxc_username             = "servarr"
        lxc_username_description = "Servarr Linux System Container"
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
      "ipv4.address"            = "10.0.0.12"
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
      source = incus_storage_volume.servarr_data.name
      pool   = var.virt_main_pool
    }
  }

  device {
    name = "cache"
    type = "disk"
    properties = {
      path   = "/var/servarr-cache"
      source = incus_storage_volume.servarr_cache.name
      pool   = var.virt_spin0_pool
    }
  }

  device {
    name = "downloads"
    type = "disk"
    properties = {
      path   = "/downloads"
      source = var.downloads_vol
      pool   = var.virt_spin0_pool
    }
  }

  device {
    name = "music"
    type = "disk"
    properties = {
      path   = "/music"
      source = var.music_vol
      pool   = var.virt_spin0_pool
    }

  }
}
