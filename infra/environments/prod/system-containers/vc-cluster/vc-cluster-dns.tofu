resource "incus_storage_volume" "vc_dns_data_0" {
  name    = "vc-dns-data-0"
  pool    = var.virt_main_pool
  project = "default"
}

resource "incus_storage_volume" "vc_dns_data_1" {
  name    = "vc-dns-data-1"
  pool    = var.virt_main_pool
  project = "default"
}

resource "incus_instance" "vc_dns_0" {
  name  = "vc-dns-0"
  image = "images:debian/trixie/cloud"
  project = "vc-cluster"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.cpu.allowance"        = "50%"
    "limits.memory"               = "4GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.module}/../cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key,
        lxc_username             = "vc-dns-0"
        lxc_username_description = "DNS Linux System Container"
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
      "ipv4.address" = "10.0.2.2"
    #   "security.acls" = join(",",
    #     [
    #       incus_network_acl.dns_inbound.name
    #   ])
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
      source = incus_storage_volume.vc_dns_data_0.name
      pool   = var.virt_main_pool
    }
  }

}


resource "incus_instance" "vc_dns_1" {
  name  = "vc-dns-1"
  image = "images:debian/trixie/cloud"
  project = "vc-cluster"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.cpu.allowance"        = "50%"
    "limits.memory"               = "4GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.module}/../cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key,
        lxc_username             = "vc-dns-1"
        lxc_username_description = "Backup DNS Linux System Container"
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
      "ipv4.address" = "10.0.2.3"
    #   "security.acls" = join(",",
    #     [
    #       incus_network_acl.dns_inbound.name
    #   ])
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
      source = incus_storage_volume.vc_dns_data_1.name
      pool   = var.virt_main_pool
    }
  }

}
