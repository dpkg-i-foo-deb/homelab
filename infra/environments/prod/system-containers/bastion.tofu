resource "incus_storage_volume" "bastion_data" {
  name    = "bastion_data"
  pool    = var.virt_main_pool
  project = "default"
  config = {
    "size" = "20GiB"
  }
}

resource "incus_instance" "bastion" {
  name  = "bastion"
  image = "images:debian/trixie/cloud"
  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.cpu.allowance"        = "20%"
    "limits.memory"               = "4GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.module}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key,
        lxc_username             = "bastion",
        lxc_username_description = "Bastion Linux System Container",
        lxc_user_password        = var.lxc_user
        ansible_password         = var.ansible_password
      }
    )
    "security.nesting" = true
  }
  device {
    name = "eth0"
    type = "nic"
    properties = {
      network        = var.management_net.name
      "ipv4.address" = "10.0.1.10"
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
      source = incus_storage_volume.bastion_data.name
      pool   = var.virt_main_pool
    }
  }
}
