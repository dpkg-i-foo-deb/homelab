resource "incus_storage_volume" "knowledge_data" {
  name    = "knowledge_data"
  pool    = var.virt_high_io_pool
  project = "default"
}

resource "incus_network_acl" "knowledge_svc" {
  name = "knowledge-svc"

  ingress = [
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "8080"
      protocol         = "tcp"
      description      = "Allow incoming connections to Trillium Next"
      state            = "enabled"
    },
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "4180"
      protocol         = "tcp"
      description      = "Allow incoming connections to oauth2-proxy"
      state            = "enabled"
    },
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "8081"
      protocol         = "tcp"
      description      = "Allow incoming connections to Freshrss"
      state            = "enabled"
    },
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "5006"
      protocol         = "tcp"
      description      = "Allow incoming connections to Actualbudget"
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
      description      = "Allow incoming connections to FitTrackee"
      state            = "enabled"
    },
  ]
}

resource "incus_instance" "knowledge" {
  name  = "knowledge"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.cpu.allowance"        = "10%"
    "limits.memory"               = "4GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key
        lxc_username             = "knowledge"
        lxc_username_description = "Knowledge management Linux System Container"
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
      "ipv4.address" = "10.0.0.10"
      "security.acls" = join(",",
        [
          incus_network_acl.knowledge_svc.name
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
      source = incus_storage_volume.knowledge_data.name
      pool   = var.virt_high_io_pool
    }
  }
}
