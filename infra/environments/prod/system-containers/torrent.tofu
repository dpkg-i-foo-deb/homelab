resource "incus_storage_volume" "torrent_data" {
  name    = "torrent_data"
  pool    = var.virt_main_pool
  project = "default"
}

resource "incus_network_acl" "torrent_svc" {
  name = "torrent-svc"

  ingress = [
    {
      action = "allow"
      source = join(",",
        [
          "192.168.8.1/24",
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "8080"
      protocol         = "tcp"
      description      = "Allow incoming connections to Qbittorrent"
      state            = "enabled"
    },
  ]
}


resource "incus_instance" "torrent" {
  name  = "torrent"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.cpu.allowance"        = "10%"
    "limits.memory"               = "4GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.module}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key,
        lxc_username             = "torrent"
        lxc_username_description = "Torrenting Linux System Container"
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
      "ipv4.address" = "10.0.6.10"
      network        = var.torrenting_net.name
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
      source = incus_storage_volume.torrent_data.name
      pool   = var.virt_main_pool
    }
  }

  device {
    name = "downloads"
    type = "disk"
    properties = {
      path   = "/downloads"
      source = var.downloads_vol
      pool   = var.virt_spin_usb_pool
    }
  }
}
