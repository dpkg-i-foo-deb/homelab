resource "incus_storage_volume" "vc_sodimac_debug_data" {
  name    = "vc-sodimac-debug-data"
  pool    = var.virt_main_pool
  project = "default"
}


resource "incus_instance" "vc_sodimac_debug" {
  name  = "vc-sodimac-debug"
  image = "images:debian/trixie/cloud"
  project = "vc-cluster"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.cpu.allowance"        = "10%"
    "limits.memory"               = "2GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key,
        lxc_username             = "vc-sodimac-debug"
        lxc_username_description = "DNS Linux System Container"
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
      network        = var.untrusted_net.name
      "ipv4.address" = "10.0.8.17"
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
      source = incus_storage_volume.vc_sodimac_debug_data.name
      pool   = var.virt_main_pool
    }
  }

}


