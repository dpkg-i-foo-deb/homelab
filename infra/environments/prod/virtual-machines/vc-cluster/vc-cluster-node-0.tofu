resource "incus_instance" "vc-node-0" {
  name    = "vc-cluster-node-0"
  type    = "virtual-machine"
  image   = "images:debian/trixie/cloud"
  project = "vc-cluster"

  config = {
    "boot.autostart" = true
    "limits.cpu"     = 2
    "limits.memory"  = "16GiB"
    "cloud-init.user-data" = templatefile(
      "${path.module}/../cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key
        lxc_username             = "vc-cluster-node-0"
        lxc_username_description = "vc worker node"
        lxc_user_password        = var.lxc_user_password
        ansible_password         = var.ansible_password
      }
    )
  }
  device {
    name = "eth0"
    type = "nic"
    properties = {
      network        = var.untrusted_net.name
      "ipv4.address" = "10.0.8.14"
    }
  }
  device {
    name = "root"
    type = "disk"
    properties = {
      path = "/"
      pool = var.virt_high_io_pool
      size = "100GiB"
    }
  }

}
