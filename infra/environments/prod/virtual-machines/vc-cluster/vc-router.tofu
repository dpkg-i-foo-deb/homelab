resource "incus_instance" "vc-router" {
  name    = "vc-router"
  project = "vc-cluster"
  type    = "virtual-machine"
  running = "false"

  config = {
    "boot.autostart" = true
    "limits.cpu"     = 1
    # "limits.cpu.allowance"        = "10%"
    "limits.memory" = "2GiB"
    # "limits.memory.swap"          = "true"
    # "limits.memory.swap.priority" = "0"
    # "limits.kernel.memlock"       = "unlimited"
    "cloud-init.user-data" = templatefile(
      "${path.module}/../cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key
        lxc_username             = "vc-node"
        lxc_username_description = "vc worker node"
        lxc_user_password        = var.lxc_user_password
        ansible_password         = var.ansible_password
      }
    )
    # "security.nesting"    = true
    # "security.privileged" = true
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
      "boot.priority" = 10
      path            = "/"
      pool            = var.virt_high_io_pool
    }
  }

  device {
    name = "installer"
    type = "disk"
    properties = {
      "boot.priority" = 1
      source          = "/var/images/opnsense.img"
    }
  }

}
