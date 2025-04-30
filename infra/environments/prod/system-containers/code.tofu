resource "incus_storage_volume" "code_data" {
  name    = "code_data"
  pool    = var.virt_high_io_pool
  project = "default"
  config = {
    "size" = "40GiB"
  }
}

resource "incus_network_acl" "code_svc" {
  name = "code-svc"

  ingress = [
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "8443,8444,8080,4180,4181"
      protocol         = "tcp"
      description      = "Allow incoming connections to code-server"
      state            = "enabled"
    },
  ]
  egress = [
    {
      action = "allow"
      destination = "10.0.8.12"
      destination_port = "2375"
      protocol         = "tcp"
      description      = "Allow outgoing connections to Docker API"
      state            = "enabled"
    },
  ]
}

resource "incus_instance" "code" {
  name  = "code"
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
        ssh_public_key           = var.ssh_public_key
        lxc_user_password        = var.lxc_user_password
        lxc_username             = "code"
        lxc_username_description = "Coding Linux System Container"
        ansible_password         = var.ansible_password
      }
    )
    "security.nesting" = true
  }

  device {
    name = "eth0"
    type = "nic"
    properties = {
      network        = var.code_net.name
      "ipv4.address" = "10.0.7.10"
      "security.acls" = join(",",
        [
          incus_network_acl.code_svc.name
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
      source = incus_storage_volume.code_data.name
      pool   = var.virt_high_io_pool
    }
  }
}
