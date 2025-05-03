resource "incus_storage_volume" "gaming_data" {
  name    = "gaming-data"
  pool    = var.virt_main_pool
  project = "default"
}

resource "incus_storage_volume" "gaming_library" {
  name    = "gaming-library"
  pool    = var.virt_spin0_pool
  project = "default"
}

resource "incus_network_acl" "gaming_svc" {
  name = "gaming-svc"

  ingress = [
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "47990,47984,47989,48010"
      protocol         = "tcp"
      description      = "Allow incoming connections to Sunshine (TCP)"
      state            = "enabled"
    },
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "47998-48000"
      protocol         = "udp"
      description      = "Allow incoming connections to Sunshine (UDP)"
      state            = "enabled"
      }, {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "21118"
      protocol         = "tcp"
      description      = "Allow incoming connections to Rustdesk(TCP)"
      state            = "enabled"
    },
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "21118"
      protocol         = "udp"
      description      = "Allow incoming connections to Rustdesk(UDP)"
      state            = "enabled"
    },
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "3389"
      protocol         = "tcp"
      description      = "Allow incoming connections to RDP (TCP)"
      state            = "enabled"
    },
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "3389"
      protocol         = "udp"
      description      = "Allow incoming connections to RDP (UDP)"
      state            = "enabled"
    },
  ]
}

resource "incus_instance" "gaming" {
  name  = "gaming"
  image = "images:debian/bookworm/cloud"
  type= "virtual-machine"

  config = {
    "boot.autostart" = false
    "limits.cpu"     = 2
    # "limits.cpu.allowance"        = "50%"
    #"raw.lxc"       = "lxc.cgroup2.devices.allow = a"
    "limits.memory" = "8GiB"
    # "limits.memory.swap"          = "true"
    # "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key
        lxc_username             = "gaming"
        lxc_username_description = "Game Server Linux System Container"
        lxc_user_password        = var.lxc_user_password
        ansible_password         = var.ansible_password
      }
    )
    "security.nesting" = true
    "raw.qemu.conf": "[device \"qemu_gpu\"]"
  }
  device {
    name = "eth0"
    type = "nic"
    properties = {
      network        = var.untrusted_net.name
      "ipv4.address" = "10.0.8.14"
      "security.acls" = join(",",
        [
          incus_network_acl.gaming_svc.name
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
      source = incus_storage_volume.gaming_data.name
      pool   = var.virt_main_pool
    }
  }

  device {
    name = "library"
    type = "disk"
    properties = {
      path   = "/library"
      source = incus_storage_volume.gaming_library.name
      pool   = var.virt_spin0_pool
    }
  }

  device {
    name = "gpu"
    type = "gpu"
    properties = {
      pci = "01:00.0"
      # gid = "44"
    }
  }

}
