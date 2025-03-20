resource "incus_storage_volume" "game-server-data" {
  name = "game-server"
  pool = var.virt_high_io_pool
  project = "default"
}

resource "incus_instance" "game-server" {
  name  = "game-server"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 2
    "limits.memory"               = "8GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.module}/cloud-init/game-server.yml.tftpl",
      {
        ssh_public_key    = var.ssh_public_key
        lxc_user_password = var.lxc_user_password
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
      parent         = var.untrusted_net
      "ipv4.address" = "10.0.8.11"
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
      source = incus_storage_volume.game-server-data.name
      pool   = var.virt_high_io_pool
    }
  }
}
