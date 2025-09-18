resource "incus_instance" "vc_support" {
  name  = "vc-support"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 2
    "limits.cpu.allowance"        = "30%"
    "limits.memory"               = "8GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key
        lxc_user_password        = var.lxc_user_password
        lxc_username             = "vcsoft"
        lxc_username_description = "VC Support Linux System Container"
        ansible_password         = var.ansible_password
      }
    )
    "security.nesting" = true
  }

  device {
    name = "eth0"
    type = "nic"
    properties = {
      network        = var.vcsoft_net.name
      "ipv4.address" = "10.0.3.12"
    }
  }

  device {
    name = "root"
    type = "disk"
    properties = {
      path = "/"
      pool = var.virt_main_pool.name
      size = "20GiB"
    }
  }
}
