resource "incus_storage_volume" "password_manager_data" {
  name    = "password-manager-data"
  pool    = var.virt_main_pool
  project = "default"
  config = {
    size = "5GiB"
  }
}

resource "incus_instance" "password_manager" {
  name  = "password-manager"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.cpu.allowance"        = "10%"
    "limits.memory"               = "512MiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key,
        lxc_username             = "password-manager"
        lxc_username_description = "Password Manager Linux System Container"
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
      "ipv4.address" = "10.0.254.4"
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
      source = incus_storage_volume.password_manager_data.name
      pool   = var.virt_main_pool
    }
  }

}


