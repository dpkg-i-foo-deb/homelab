resource "incus_storage_volume" "code_data" {
  name = "code_data"
  pool = incus_storage_pool.virt-high-io.name
  config = {
    "size" = "40GiB"
  }
}

resource "incus_instance" "code" {
  name  = "code"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.memory"               = "4GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.module}/cloud-init/code_lxc.yml.tftpl",
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
      parent         = "${incus_network.code.name}"
      "ipv4.address" = "10.0.7.10"
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
      source = incus_storage_volume.code_data.name
      pool   = incus_storage_pool.virt-high-io.name
    }
  }
}
