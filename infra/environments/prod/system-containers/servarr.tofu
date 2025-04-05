resource "incus_storage_volume" "servarr_data" {
  name    = "servarr_data"
  pool    = var.virt_main_pool
  project = "default"
  config = {
    "size" = "30GiB"
  }
}

resource "incus_storage_volume" "servarr_cache" {
  name    = "servarr-cache"
  pool    = var.virt_high_io_pool
  project = "default"
  config = {
    "size" = "20GiB"
  }
}

resource "incus_network_acl" "servarr_svc" {
  name = "servarr-svc"

  ingress = [
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "8686"
      protocol         = "tcp"
      description      = "Allow incoming connections to Lidarr"
      state            = "enabled"
    },
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "9696"
      protocol         = "tcp"
      description      = "Allow incoming connections to Prowlarr"
      state            = "enabled"
    },
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "5000"
      protocol         = "tcp"
      description      = "Allow incoming connections to LidaTube"
      state            = "enabled"
    },
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "8265,8266"
      protocol         = "tcp"
      description      = "Allow incoming connections to Tdarr"
      state            = "enabled"
    },
  ]
  egress = [
    {
      action           = "allow"
      destination      = var.torrenting_net.config["ipv4.address"]
      destination_port = "8080"
      protocol         = "tcp"
      description      = "Allow connections to Qbittorrent"
      state            = "enabled"
    }
  ]

}

resource "incus_instance" "servarr" {
  name  = "servarr"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.cpu.allowance"        = "20%"
    "limits.memory"               = "12GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.module}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key,
        lxc_username             = "servarr"
        lxc_username_description = "Servarr Linux System Container"
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
      network        = var.trusted_net.name
      "ipv4.address" = "10.0.0.12"
      "security.acls" = join(",",
        [
          incus_network_acl.servarr_svc.name
      ])
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
      source = incus_storage_volume.servarr_data.name
      pool   = var.virt_main_pool
    }
  }

  device {
    name = "cache"
    type = "disk"
    properties = {
      path   = "/var/servarr-cache"
      source = incus_storage_volume.servarr_cache.name
      pool   = var.virt_spin0_pool
    }
  }

  device {
    name = "downloads"
    type = "disk"
    properties = {
      path   = "/downloads"
      source = var.downloads_vol
      pool   = var.virt_spin0_pool
    }
  }

  device {
    name = "music"
    type = "disk"
    properties = {
      path   = "/music"
      source = var.music_vol
      pool   = var.virt_spin0_pool
    }

  }
}
