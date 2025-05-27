resource "incus_network_acl" "vc_bastion_svc" {
  name = "vc-bastion-svc"

  egress = [
    {
      action           = "allow"
      destination      = "10.0.10.10/32,10.0.2.6/32,10.0.2.7/32"
      destination_port = "22"
      protocol         = "tcp"
      description      = "Allow outgoing SSH connections (TCP) to VC machines"
      state            = "enabled"
    }
  ]
}

resource "incus_instance" "vc_bastion" {
  name    = "vc-bastion"
  image   = "images:debian/trixie/cloud"
  project = "vcsoft"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.cpu.allowance"        = "10%"
    "limits.memory"               = "1GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key
        lxc_user_password        = var.lxc_user_password
        lxc_username             = "vcsoft"
        lxc_username_description = "VC Bastion Linux System Container"
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
      "ipv4.address" = "10.0.10.5"
      "security.acls" = join(",",
        [
          incus_network_acl.vc_bastion_svc.name
      ])
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
}
