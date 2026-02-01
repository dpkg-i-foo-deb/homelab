resource "incus_instance" "automation" {
  name  = "automation"
  type  = "virtual-machine"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"      = true
    "limits.cpu"          = 3
    "limits.memory"       = "12GiB"
    "security.secureboot" = true
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key
        lxc_username             = "automation"
        lxc_username_description = "Host to run automation tools"
        lxc_user_password        = var.lxc_user_password
        ansible_password         = var.ansible_password
      }
    )
  }

  device {
    name = "eth0"
    type = "nic"
    properties = {
      network        = var.management_net.name
      "ipv4.address" = "10.0.1.11"
      "security.ipv4_filtering" = true
      "security.ipv6_filtering" = true
      "security.mac_filtering"  = true
    }
  }

  device {
    name = "root"
    type = "disk"
    properties = {
      path = "/"
      pool = var.virt_main_pool
      size = "50GiB"
    }
  }
}



