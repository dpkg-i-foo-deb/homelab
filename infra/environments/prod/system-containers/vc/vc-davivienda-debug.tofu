resource "incus_instance" "vc_davivienda_debug" {
  name  = "vc-davivienda-debug"
  image = "images:debian/trixie/cloud"
  project = "vcsoft"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.cpu.allowance"        = "20%"
    "limits.memory"               = "2GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key
        lxc_user_password        = var.lxc_user_password
        lxc_username             = "vcsoft"
        lxc_username_description = "VC Davivienda Debug Linux System Container"
        ansible_password         = var.ansible_password
      }
    )
    "security.nesting" = true
  }

  device {
    name = "eth0"
    type = "nic"
    properties = {
      network        = var.work_net.name
      "ipv4.address" = "10.0.10.11"
    }
  }

  device {
    name = "root"
    type = "disk"
    properties = {
      path = "/"
      pool = var.virt_high_io_pool
    }
  }
}
