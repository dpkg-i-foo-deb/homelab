resource "incus_network_acl" "vc_sodimac_dns_inbound" {
  name = "vc-sodimac-dns-inbound"

  ingress = [
    {
      action           = "allow"
      source           = "10.0.10.5/24"
      destination_port = "22"
      protocol         = "tcp"
      description      = "Allow VC Bastion to manage this machine"
      state            = "enabled"
    },
  ]
}

resource "incus_storage_volume" "vc_sodimac_dns_data" {
  name = "vc-sodimac-dns-data"
  pool = var.virt_main_pool
}

resource "incus_instance" "vc_sodimac_dns" {
  name    = "vc-sodimac-dns"
  image   = "images:debian/trixie/cloud"
  project = "vcsoft"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.cpu.allowance"        = "20%"
    "limits.memory"               = "2GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key,
        lxc_username             = "vcsoft"
        lxc_username_description = "VCSOFT Sodimac DNS System Container"
        lxc_user_password        = var.lxc_user_password,
        ansible_password         = var.ansible_password
      }
    )
    "security.nesting" = true
  }
  device {
    name = "eth0"
    type = "nic"
    properties = {
      network        = var.dns_net.name
      "ipv4.address" = "10.0.2.6"
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
    name = "data"
    type = "disk"
    properties = {
      path   = "/home"
      source = incus_storage_volume.vc_sodimac_dns_data.name
      pool   = var.virt_main_pool
    }
  }

}
