resource "incus_storage_volume" "streaming_data" {
  name    = "streaming_data"
  pool    = var.virt_main_pool
  project = "default"
  config  = {
     "size" = "30GiB"
  }
}

resource "incus_storage_volume" "streaming_cache" {
  name    = "streaming-cache"
  pool    = var.virt_high_io_pool
  project = "default"
  config = {
    "size" = "100GiB"
  }
}

resource "incus_instance" "streaming" {
  name  = "streaming"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 2
    "limits.cpu.allowance"        = "50%"
    "limits.memory"               = "12GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key,
        lxc_username             = "streaming"
        lxc_username_description = "Streaming Linux System Container"
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
      "ipv4.address" = "10.0.0.13"
    }
  }

  device {
    name = "root"
    type = "disk"
    properties = {
      path = "/"
      pool = var.virt_main_pool
      size = "20GiB"
    }
  }

  device {
    name = "data"
    type = "disk"
    properties = {
      path   = "/home"
      source = incus_storage_volume.streaming_data.name
      pool   = var.virt_main_pool
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

  device {
    name = "photos"
    type = "disk"
    properties = {
      path   = "/photos"
      source = var.photos_vol
      pool   = var.virt_spin0_pool
    }
  }

  device {
    name = "cache"
    type = "disk"
    properties = {
      path   = "/cache"
      source = incus_storage_volume.streaming_cache.name
      pool   = var.virt_high_io_pool
    }
  }
}
