resource "incus_storage_volume" "subnet_router_data" {
  name    = "subnet_router_data"
  pool    = var.virt_main_pool
  project = "default"
}

resource "incus_instance" "subnet_router" {
  name  = "subnet-router"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.memory"               = "2GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key
        lxc_username             = "subnet-router"
        lxc_username_description = "Reverse proxy Linux System Container"
        lxc_user_password        = var.lxc_user_password
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
      "ipv4.address" = "10.0.0.5"
    }
  }

  device {
    name = "eth1"
    type = "nic"
    properties = {
      network = var.reverse_proxy_net.name
      "ipv4.address" = "10.0.5.5"
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
      source = incus_storage_volume.subnet_router_data.name
      pool   = var.virt_main_pool
    }
  }
}
