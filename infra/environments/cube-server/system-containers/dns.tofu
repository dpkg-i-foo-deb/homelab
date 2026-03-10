resource "incus_storage_volume" "dns_home_data" {
  name    = "dns-home-data"
  pool    = var.virt_main_pool
  project = "default"
}

resource "incus_storage_volume" "dns_vpn_data" {
  name    = "dns-vpn-data"
  pool    = var.virt_main_pool
  project = "default"
}

resource "incus_storage_volume" "dns_home_unrestricted_data" {
  name    = "dns-home-unrestricted-data"
  pool    = var.virt_main_pool
  project = "default"
}

resource "incus_instance" "dns_home" {
  name  = "dns-home-0"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 2
    "limits.cpu.allowance"        = "50%"
    "limits.memory"               = "4GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key,
        lxc_username             = "bmc"
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
      network                   = var.dns_net.name
      "ipv4.address"            = "10.0.2.2"
      "security.ipv4_filtering" = true
      "security.ipv6_filtering" = true
      "security.mac_filtering"  = true
      "security.port_isolation" = true
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
      source = incus_storage_volume.dns_home_data.name
      pool   = var.virt_main_pool
    }
  }

  device {
    name = "tmp"
    type = "disk"
    properties = {
      path   = "/tmp"
      fstype = "tmpfs"
      source = "none"
    }
  }

  device {
    name = "vartmp"
    type = "disk"
    properties = {
      path   = "/var/tmp"
      fstype = "tmpfs"
      source = "none"
    }
  }

}

resource "incus_instance" "dns_home_unrestricted" {
  name  = "dns-home-unrestricted"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 2
    "limits.cpu.allowance"        = "50%"
    "limits.memory"               = "4GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key,
        lxc_username             = "bmc"
        lxc_username_description = "Unrestricted DNS Linux System Container"
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
      network                   = var.dns_net.name
      "ipv4.address"            = "10.0.2.3"
      "security.ipv4_filtering" = true
      "security.ipv6_filtering" = true
      "security.mac_filtering"  = true
      "security.port_isolation" = true
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
      source = incus_storage_volume.dns_home_unrestricted_data.name
      pool   = var.virt_main_pool
    }
  }

  device {
    name = "tmp"
    type = "disk"
    properties = {
      path   = "/tmp"
      fstype = "tmpfs"
      source = "none"
    }
  }

  device {
    name = "vartmp"
    type = "disk"
    properties = {
      path   = "/var/tmp"
      fstype = "tmpfs"
      source = "none"
    }
  }

}

resource "incus_instance" "dns_vpn" {
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
        lxc_username             = "bmc"
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
      network                   = var.dns_net.name
      "ipv4.address"            = "10.0.2.4"
      "security.ipv4_filtering" = true
      "security.ipv6_filtering" = true
      "security.mac_filtering"  = true
      "security.port_isolation" = true
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
      source = incus_storage_volume.dns_vpn_data.name
      pool   = var.virt_main_pool
    }
  }

  device {
    name = "tmp"
    type = "disk"
    properties = {
      path   = "/tmp"
      fstype = "tmpfs"
      source = "none"
    }
  }

  device {
    name = "vartmp"
    type = "disk"
    properties = {
      path   = "/var/tmp"
      fstype = "tmpfs"
      source = "none"
    }
  }

}
