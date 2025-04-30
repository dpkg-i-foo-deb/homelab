resource "incus_instance" "vc-plane-0" {
  name    = "vc-cluster-plane-0"
  type    = "virtual-machine"
  image   = "images:debian/trixie/cloud"
  project = "vc-cluster"

  config = {
    "boot.autostart" = true
    "limits.cpu"     = 1
    "limits.memory"  = "2GiB"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key
        lxc_username             = "vc-cluster-plane-0"
        lxc_username_description = "vc control plane"
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
      "ipv4.address" = "10.0.8.16"
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
