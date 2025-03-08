resource "incus_storage_volume" "dns_data" {
  name = "dns_data"
  pool = incus_storage_pool.virt-main.name
}

resource "incus_storage_volume" "dns_data_1" {
  name = "dns_data_1"
  pool = incus_storage_pool.virt-main.name
}

resource "incus_instance" "dns" {
  name  = "dns"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.cpu.allowance"        = "10%"
    "limits.memory"               = "2GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.module}/cloud-init/dns_lxc.yml.tftpl",
      {
        ssh_public_key    = var.ssh_public_key,
        lxc_user_password = var.lxc_user_password,
        ansible_password  = var.ansible_password
      }
    )
    "security.nesting" = true
  }
  device {
    name = "eth0"
    type = "nic"
    properties = {
      nictype        = "bridged"
      parent         = "${incus_network.dns.name}"
      "ipv4.address" = "10.0.2.2"
      mtu            = "9000"
    }
  }

  device {
    name = "root"
    type = "disk"
    properties = {
      path = "/"
      pool = incus_storage_pool.virt-main.name
    }
  }

  device {
    name = "data"
    type = "disk"
    properties = {
      path   = "/home"
      source = incus_storage_volume.dns_data.name
      pool   = incus_storage_pool.virt-main.name
    }
  }

}


resource "incus_instance" "dns_1" {
  name  = "dns-1"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.cpu.allowance"        = "10%"
    "limits.memory"               = "2GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.module}/cloud-init/dns_1_lxc.yml.tftpl",
      {
        ssh_public_key    = var.ssh_public_key,
        lxc_user_password = var.lxc_user_password,
        ansible_password  = var.ansible_password
      }
    )
    "security.nesting" = true
  }
  device {
    name = "eth0"
    type = "nic"
    properties = {
      nictype        = "bridged"
      parent         = "${incus_network.dns.name}"
      "ipv4.address" = "10.0.2.3"
      mtu            = "9000"
    }
  }

  device {
    name = "root"
    type = "disk"
    properties = {
      path = "/"
      pool = incus_storage_pool.virt-main.name
    }
  }

  device {
    name = "data"
    type = "disk"
    properties = {
      path   = "/home"
      source = incus_storage_volume.dns_data_1.name
      pool   = incus_storage_pool.virt-main.name
    }
  }

}
