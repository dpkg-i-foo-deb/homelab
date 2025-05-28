resource "incus_network_acl" "vc_support_svc" {
  name = "vc-support-svc"

  ingress = [
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.management_net.config["ipv4.address"],
      ])
      destination_port = "3389"
      protocol         = "tcp"
      description      = "Allow incoming connections to RDP (TCP)"
      state            = "enabled"
    },
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
      ])
      destination_port = "3389"
      protocol         = "udp"
      description      = "Allow incoming connections to RDP (UDP)"
      state            = "enabled"
    },
    {
      action           = "allow"
      source           = "10.0.10.5/32"
      destination_port = "22"
      protocol         = "tcp"
      description      = "Allow incoming SSH connections (TCP)"
      state            = "enabled"
    }
  ]
}

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
      network        = var.work_net.name
      "ipv4.address" = "10.0.10.10"
      "security.acls" = join(",",
        [
          incus_network_acl.vc_support_svc.name
      ])
    }
  }

  device {
    name = "root"
    type = "disk"
    properties = {
      path = "/"
      pool = var.virt_high_io_pool
      size = "20GiB"
    }
  }
}
