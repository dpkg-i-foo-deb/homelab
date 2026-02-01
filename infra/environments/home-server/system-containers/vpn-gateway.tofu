resource "incus_instance" "vpn_gateway" {
  name  = "vpn-gateway"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.cpu.allowance"        = "50%"
    "limits.memory"               = "1GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key
        lxc_username             = "vpn-gateway"
        lxc_username_description = "VPN Gateway Linux System Container"
        lxc_user_password        = var.lxc_user_password
        ansible_password         = var.ansible_password
      }
    )
    "security.nesting" = true
  }


  # IPv4 and IPv6 filtering are disabled because they are required in order
  # for a router to work properly, since it is replacing its source ip with
  # another machine's ip... Mac filtering is still enabled to ensure
  # at least some network security

  device {
    name = "eth0"
    type = "nic"
    properties = {
      network                   = var.transit_net.name
      "ipv4.address"            = "10.0.6.20"
      "security.mac_filtering"  = true
    }
  }

  device {
    name = "eth1"
    type = "nic"
    properties = {
      network                   = var.trusted_net.name
      "ipv4.address"            = "10.0.0.20"
      "security.mac_filtering"  = true
    }
  }

  device {
    name = "eth2"
    type = "nic"
    properties = {
      network                  = var.reverse_proxy_net.name
      "ipv4.address"           = "10.0.5.20"
      "security.mac_filtering" = true
    }
  }

  device {
    name = "eth3"
    type = "nic"
    properties = {
      network                  = var.management_net.name
      "ipv4.address"           = "10.0.1.20"
      "security.mac_filtering" = true
    }
  }

  device {
    name = "eth4"
    type = "nic"
    properties = {
      network                  = var.monitoring_net.name
      "ipv4.address"           = "10.0.7.20"
      "security.mac_filtering" = true
    }
  }

  device {
    name = "root"
    type = "disk"
    properties = {
      path = "/"
      pool = var.virt_main_pool
      size = "2GiB"
    }
  }
}
