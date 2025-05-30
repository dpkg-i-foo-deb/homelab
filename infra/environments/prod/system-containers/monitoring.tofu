resource "incus_storage_volume" "monitoring_data" {
  name    = "monitoring_data"
  pool    = var.virt_main_pool
  project = "default"
}

resource "incus_storage_volume" "monitoring_metrics" {
  name    = "monitoring_metrics"
  pool    = var.virt_spin0_pool
  project = "default"
  config = {
    "size" = "50GiB"
  }
}

resource "incus_storage_volume" "monitoring_logs" {
  name    = "monitoring_logs"
  pool    = var.virt_spin0_pool
  project = "default"
  config = {
    "size" = "50GiB"
  }
}

resource "incus_network_acl" "monitoring_outbound" {
  name = "monitoring-outbound"

  egress = [
    {
      action = "allow"
      destination = join(",",
        [
          var.hypervisor_addresses
      ])
      destination_port = "8443"
      protocol         = "tcp"
      description      = "Allow outbound connections to hypervisor metrics (Incus)"
      state            = "enabled"
    },
    {
      action = "allow"
      destination = join(",",
        [
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "2019"
      protocol         = "tcp"
      description      = "Allow outbound connections to reverse proxy metrics (Caddy)"
      state            = "enabled"
    },
    {
      action = "allow"
      destination = join(",",
        [
          var.dns_net.config["ipv4.address"]
      ])
      destination_port = "4000"
      protocol         = "tcp"
      description      = "Allow outbound connections to dns metrics (Blocky)"
      state            = "enabled"
    },
    {
      action = "allow"
      destination = join(",",
        [
          var.hypervisor_addresses,
      ])
      destination_port = "9100"
      protocol         = "tcp"
      description      = "Allow outbound connections to hypervisor metrics"
      state            = "enabled"
    },
    {
      action = "allow"
      destination = join(",",
        [
          var.management_subnet,
      ])
      destination_port = "9100"
      protocol         = "tcp"
      description      = "Allow outbound connections to home network metrics"
      state            = "enabled"
    },
  ]
}

resource "incus_network_acl" "monitoring_svc" {
  name = "monitoring-svc"

  ingress = [
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "9090"
      protocol         = "tcp"
      description      = "Allow incoming connections to Prometheus Web UI"
      state            = "enabled"
    },
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "3000"
      protocol         = "tcp"
      description      = "Allow incoming connections to Grafana Web UI"
      state            = "enabled"
    },
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "3100"
      protocol         = "tcp"
      description      = "Allow incoming connections to Loki"
      state            = "enabled"
    },
  ]
}


resource "incus_instance" "monitoring" {
  name  = "monitoring"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 1
    "limits.cpu.allowance"        = "10%"
    "limits.memory"               = "2GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key
        lxc_username             = "monitoring"
        lxc_username_description = "Monitoring Linux System Container"
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
      network        = var.monitoring_net.name
      "ipv4.address" = "10.0.9.10"
      "security.acls" = join(",",
        [
          incus_network_acl.monitoring_outbound.name,
          incus_network_acl.monitoring_svc.name
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
      source = incus_storage_volume.monitoring_data.name
      pool   = var.virt_main_pool
    }
  }

  device {
    name = "metrics"
    type = "disk"
    properties = {
      path   = "/metrics"
      source = incus_storage_volume.monitoring_metrics.name
      pool   = var.virt_spin0_pool
    }
  }

  device {
    name = "logs"
    type = "disk"
    properties = {
      path   = "/logs"
      source = incus_storage_volume.monitoring_logs.name
      pool   = var.virt_spin0_pool
    }
  }
}



