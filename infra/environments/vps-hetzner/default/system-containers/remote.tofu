resource "incus_storage_volume" "remote_data" {
  name    = "remote_data"
  pool    = var.virt_main_pool
  project = "default"
  config = {
    size = "5GiB"
  }
}

resource "incus_instance" "remote" {
  name  = "remote"
  image = "images:debian/trixie/cloud"
  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 2
    "limits.memory"               = "4GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key
        lxc_username             = "bmc"
        lxc_username_description = "remote Linux System Container"
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
      network                   = var.management_net.name
      "ipv4.address"            = "10.0.251.10"
      "security.ipv4_filtering" = true
      "security.ipv6_filtering" = true
      "security.mac_filtering"  = true
      "security.port_isolation" = false
    }
  }

  device {
    name = "root"
    type = "disk"
    properties = {
      path = "/"
      pool = var.virt_main_pool
      size = "2GiB"
    }
  }

  device {
    name = "data"
    type = "disk"
    properties = {
      path   = "/home"
      source = incus_storage_volume.remote_data.name
      pool   = var.virt_main_pool
    }
  }

  device {
    name = "tmp"
    type = "disk"
    properties = {
      path   = "/tmp"
      source = "tmpfs:"
    }
  }

  device {
    name = "vartmp"
    type = "disk"
    properties = {
      path   = "/var/tmp"
      source = "tmpfs:"
    }
  }
}
