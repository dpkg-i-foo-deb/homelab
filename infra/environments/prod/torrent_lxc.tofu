resource "incus_storage_volume" "torrent_data" {
  name = "torrent_data"
  pool = incus_storage_pool.virt-main.name
}

resource "incus_instance" "torrent" {
  name  = "torrent"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.cpu.allowance"        = "10%"
    "limits.memory"               = "4GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.module}/cloud-init/torrent_lxc.yml.tftpl",
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
      parent         = "${incus_network.torrenting.name}"
      "ipv4.address" = "10.0.6.10"
      mtu            = "9000"
    }
  }

  device {
    name = "root"
    type = "disk"
    properties = {
      path = "/"
      pool = incus_storage_pool.virt-main.name
    }
  }

  device {
    name = "data"
    type = "disk"
    properties = {
      path   = "/home"
      source = incus_storage_volume.torrent_data.name
      pool   = incus_storage_pool.virt-main.name
    }
  }

  device {
    name = "downloads"
    type = "disk"
    properties = {
      path   = "/downloads"
      source = incus_storage_volume.downloads.name
      pool   = incus_storage_pool.virt-spin-usb.name
    }
  }
}
