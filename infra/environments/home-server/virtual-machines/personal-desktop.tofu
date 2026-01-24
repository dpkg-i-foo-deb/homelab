resource "incus_instance" "personal_desktop" {
  name  = "personal-desktop"
  type    = "virtual-machine"
  image = "images:ubuntu/questing/cloud"

  config = {
    "boot.autostart" = true
    "limits.cpu"     = 2
    "limits.memory"  = "8GiB"
    "security.secureboot" = true
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key
        lxc_username             = "personal-desktop"
        lxc_username_description = "Host to run personal-desktop tools"
        lxc_user_password        = var.lxc_user_password
        ansible_password         = var.ansible_password
      }
    )
  }

  device {
    name = "eth0"
    type = "nic"
    properties = {
      network        = var.trusted_net.name
      "ipv4.address" = "10.0.0.19"
    }
  }

  device {
    name = "root"
    type = "disk"
    properties = {
      path = "/"
      pool = var.virt_main_pool
      size = "20GiB"
    }
  }
}



