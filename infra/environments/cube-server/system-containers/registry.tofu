resource "incus_storage_volume" "registry_data" {
  name    = "registry_data"
  pool    = var.virt_main_pool
  project = "default"
  config = {
    "size" = "15GiB"
  }
}

resource "incus_storage_volume" "registry_blobs" {
  name    = "registry-blobs"
  pool    = var.virt_main_pool
  project = "default"
  config = {
    "size" = "40GiB"
  }
}


resource "incus_instance" "registry" {
  name  = "registry"
  image = "images:debian/trixie/cloud"

  config = {
    "boot.autostart"              = true
    "limits.cpu"                  = 2
    "limits.cpu.allowance"        = "10%"
    "limits.memory"               = "4GiB"
    "limits.memory.swap"          = "true"
    "limits.memory.swap.priority" = "0"
    "cloud-init.user-data" = templatefile(
      "${path.root}/cloud-init/generic.yml.tftpl",
      {
        ssh_public_key           = var.ssh_public_key,
        lxc_username             = "bmc"
        lxc_username_description = "registry Linux System Container"
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
      network                   = var.trusted_net.name
      "ipv4.address"            = "10.0.0.14"
      "security.ipv4_filtering" = true
      "security.ipv6_filtering" = true
      "security.mac_filtering"  = true
      "security.port_isolation" = true
    }
  }

  device {
    name = "root"
    type = "disk"
    properties = {
      path = "/"
      pool = var.virt_main_pool
      size = "20GiB"
    }
  }

  device {
    name = "data"
    type = "disk"
    properties = {
      path   = "/home"
      source = incus_storage_volume.registry_data.name
      pool   = var.virt_main_pool
    }
  }

  device {
    name = "blobs"
    type = "disk"
    properties = {
      path   = "/blobs"
      source = incus_storage_volume.registry_blobs.name
      pool   = var.virt_main_pool
    }
  }

  device {
    name = "tmp"
    type = "disk"
    properties = {
      path   = "/tmp"
      fstype = "tmpfs"
      source = "none"
    }
  }

  device {
    name = "vartmp"
    type = "disk"
    properties = {
      path   = "/var/tmp"
      fstype = "tmpfs"
      source = "none"
    }
  }
}
