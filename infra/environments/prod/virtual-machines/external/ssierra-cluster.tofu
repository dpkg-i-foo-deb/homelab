resource "incus_instance" "ssierra-cluster" {
  name    = "ssierra-cluster"
  type    = "virtual-machine"
  image   = "images:debian/trixie/cloud"
  project = "external"

  config = {
    "boot.autostart"      = true
    "limits.cpu"          = 2
    "limits.memory"       = "8GiB"
    "security.secureboot" = true
    "cloud-init.user-data" = templatefile(
      "${path.module}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key
        lxc_username             = "ssierra"
        lxc_username_description = "External k8s cluster"
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
      "ipv4.address" = "10.0.11.10"
    }
  }

  device {
    name = "root"
    type = "disk"
    properties = {
      path = "/"
      pool = var.virt_high_io_pool
      size = "40GiB"
    }
  }
}



