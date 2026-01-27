resource "incus_storage_volume" "dns_home_data_0" {
  name    = "dns-home-data-0"
  pool    = var.virt_main_pool
  project = "default"
}

resource "incus_storage_volume" "dns_vpn_data_0" {
  name    = "dns-vpn-data-0"
  pool    = var.virt_main_pool
  project = "default"
}

resource "incus_instance" "dns_home_0" {
  name  = "dns-home-0"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 2
    "limits.memory"               = "8GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key,
        lxc_username             = "dns-home-0"
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
      source = incus_storage_volume.dns_home_data_0.name
      pool   = var.virt_main_pool
    }
  }

}

resource "incus_instance" "dns_vpn_0" {
  name  = "dns-vpn-0"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.cpu.allowance"        = "50%"
    "limits.memory"               = "4GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key,
        lxc_username             = "dns-vpn-0"
        lxc_username_description = "DNS server for VPN"
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
      "ipv4.address" = "10.0.2.4"
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
      source = incus_storage_volume.dns_vpn_data_0.name
      pool   = var.virt_main_pool
    }
  }

}
