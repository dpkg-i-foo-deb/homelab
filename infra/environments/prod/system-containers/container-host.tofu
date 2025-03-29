resource "incus_storage_volume" "container_host_data" {
  name    = "container_host_data"
  pool    = var.virt_high_io_pool
  project = "default"
}

resource "incus_storage_volume" "container_host_docker_volumes" {
  name    = "container_host_docker_volumes"
  pool    = var.virt_high_io_pool
  project = "default"
  config = {
    "size" = "50GiB"
  }
}

resource "incus_network_acl" "container_host_inbound" {
  name = "container-host-inbound"
  ingress = [
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.code_net.config["ipv4.address"],
      ])
      destination_port = "2375-2376"
      protocol         = "tcp"
      description      = "Allow incoming connections to Docker daemon"
      state            = "enabled"
    },
  ]
}

resource "incus_instance" "container_host" {
  name  = "container-host"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.cpu.allowance"        = "10%"
    "limits.memory"               = "8GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data"        = <<-EOT
      #cloud-config
      network:
        config: disabled
      packages:
        - podman
    EOT
    "security.nesting"            = true
  }

  device {
    name = "eth0"
    type = "nic"
    properties = {
      network        = var.untrusted_net.name
      "ipv4.address" = "10.0.8.12"
      "security.acls" = join(",",
        [
          incus_network.container_host_inbound.name
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
      source = incus_storage_volume.container_host_data.name
      pool   = var.virt_high_io_pool
    }
  }
  device {
    name = "var"
    type = "disk"
    properties = {
      path   = "/var/lib/docker/volumes"
      source = incus_storage_volume.container_host_docker_volumes.name
      pool   = var.virt_high_io_pool
    }
  }
}
