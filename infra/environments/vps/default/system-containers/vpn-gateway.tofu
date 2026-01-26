resource "incus_instance" "vpn_gateway" {
  name  = "vpn-gateway"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.cpu.allowance"        = "50%"
    "limits.memory"               = "256MiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key,
        lxc_username             = "vpn-gateway"
        lxc_username_description = "vpn-gateway Linux System Container"
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
      network        = var.transit_net.name
      "ipv4.address" = "10.0.252.20"
    }
  }

  device {
    name = "eth1"
    type = "nic"
    properties = {
      network        = var.trusted_net.name
      "ipv4.address" = "10.0.254.20"
    }
  }

  device {
    name = "eth2"
    type = "nic"
    properties = {
      network        = var.dmz_net.name
      "ipv4.address" = "10.0.253.20"
    }
  }


  device {
    name = "wg_proxy"
    type = "proxy"

    properties = {
      listen  = "udp:178.156.140.92:51820"
      connect = "udp:10.0.252.20:51820"
      nat     = "true"
    }
  }

  device {
    name = "wg_mon"
    type = "proxy"

    properties = {
      listen  = "udp:178.156.140.92:51821"
      connect = "udp:10.0.252.20:51821"
      nat     = "true"
    }
  }

  device {
    name = "wg_mgmt"
    type = "proxy"

    properties = {
      listen  = "udp:178.156.140.92:51822"
      connect = "udp:10.0.252.20:51822"
      nat     = "true"
    }
  }

  device {
    name = "wg_admin"
    type = "proxy"

    properties = {
      listen  = "udp:178.156.140.92:51823"
      connect = "udp:10.0.252.20:51823"
      nat     = "true"
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
