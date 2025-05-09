resource "incus_network_acl" "ssierra_cluster_svc" {
  name = "ssierra-cluster-svc"

  ingress = [
    {
      action = "allow"
      source = join(",",
        [
          var.management_subnet,
          var.reverse_proxy_net.config["ipv4.address"]
      ])
      destination_port = "6443"
      protocol         = "tcp"
      description      = "Allow incoming connections to kubernetes API"
      state            = "enabled"
    },
  ]
}

resource "incus_instance" "ssierra-cluster" {
  name    = "ssierra-cluster"
  type    = "virtual-machine"
  image   = "images:debian/trixie/cloud"
  project = "external"

  config = {
    "boot.autostart"      = true
    "limits.cpu"          = 2
    "limits.memory"       = "8GiB"
    "security.secureboot" = true
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key
        lxc_username             = "ssierra"
        lxc_username_description = "External k8s cluster"
        lxc_user_password        = var.lxc_user_password
        ansible_password         = var.ansible_password
      }
    )
  }

  device {
    name = "eth0"
    type = "nic"
    properties = {
      network        = var.external_net.name
      "ipv4.address" = "10.0.11.10"
      "security.acls" = join(",",
        [
          incus_network_acl.ssierra_cluster_svc.name
      ])
    }
  }

  device {
    name = "root"
    type = "disk"
    properties = {
      path = "/"
      pool = var.virt_high_io_pool
      size = "40GiB"
    }
  }
}



