resource "incus_storage_volume" "gaming_data" {
  name    = "gaming-data"
  pool    = var.virt_main_pool
  project = "default"
}

resource "incus_storage_volume" "gaming_library" {
  name    = "gaming-library"
  pool    = var.virt_spin0_pool
  project = "default"
}

resource "incus_instance" "gaming" {
  name  = "gaming"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 2
    "limits.cpu.allowance"        = "50%"
    "limits.memory"               = "8GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key
        lxc_username             = "gaming"
        lxc_username_description = "Game Server Linux System Container"
        lxc_user_password        = var.lxc_user_password
        ansible_password         = var.ansible_password
      }
    )
    "security.nesting" = true
  }
  device {
    name = "eth0"
    type = "nic"
    properties = {
      network        = var.untrusted_net.name
      "ipv4.address" = "10.0.8.12"
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
      source = incus_storage_volume.gaming_data.name
      pool   = var.virt_main_pool
    }
  }

  device {
    name = "library"
    type = "disk"
    properties = {
      path   = "/library"
      source = incus_storage_volume.gaming_library.name
      pool   = var.virt_spin0_pool
    }
  }

  device {
    name = "gpu"
    type = "gpu"
    properties = {
        pci = "01:00.0"
    }
  }
}
