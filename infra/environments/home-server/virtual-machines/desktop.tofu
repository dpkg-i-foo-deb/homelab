resource "incus_storage_volume" "desktop_data" {
  name    = "desktop_data"
  pool    = var.virt_high_io_pool
  project = "default"
  config = {
    "size" = "40GiB"
  }
}

resource "incus_instance" "desktop" {
  name  = "desktop"
  type  = "virtual-machine"
  image = "images:ubuntu/questing/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 2
    "limits.memory"               = "8GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key
        lxc_user_password        = var.lxc_user_password
        lxc_username             = "desktop"
        lxc_username_description = "Desktop Main User"
        ansible_password         = var.ansible_password
      }
    )
    "security.nesting" = true
  }

  device {
    name = "eth0"
    type = "nic"
    properties = {
      network        = var.trusted_net.name
      "ipv4.address" = "10.0.0.17"
      "security.acls" = join(",", [
        var.base_acl,
        var.management_ingress_acl,
        var.web_client_acl,
      ])
      "security.ipv4_filtering" = true
      "security.ipv6_filtering" = true
      "security.mac_filtering"  = true
      "security.port_isolation" = true
    }
  }

  device {
    name       = "tpm"
    type       = "tpm"
    properties = {}
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
      source = incus_storage_volume.desktop_data.name
      pool   = var.virt_high_io_pool
    }
  }
}
