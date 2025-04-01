resource "incus_instance" "vc-node" {
  name    = "vc-node"
  type    = "virtual-machine"
  image   = "images:debian/trixie/cloud"
  project = "vc-cluster"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.cpu.allowance"        = "30%"
    "limits.memory"               = "8GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "limits.kernel.memlock"       = "unlimited"
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
    "security.nesting"    = true
    "security.privileged" = true
    "raw.lxc"             = <<-EOT
      lxc.apparmor.profile=unconfined
      lxc.mount.auto=proc:rw sys:rw cgroup:rw
      lxc.cap.drop=
      lxc.cgroup.devices.allow=a
    EOT
  }
  device {
    name = "eth0"
    type = "nic"
    properties = {
      network        = var.untrusted_net.name
      "ipv4.address" = "10.0.8.13"
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
    name = "kmsg"
    type = "unix-char"
    properties = {
      source = "/dev/kmsg"
      path   = "/dev/kmsg"
    }
  }
}
