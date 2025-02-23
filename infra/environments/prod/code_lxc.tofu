resource "incus_storage_volume" "code_data" {
  name = "code_data"
  pool = incus_storage_pool.high_io.name
}

resource "incus_instance" "code" {
  name  = "code"
  image = "images:almalinux/9/cloud"

  config = {
    "boot.autostart" = true
    "limits.cpu"     = 1
    "limits.memory"  = "2GiB"
  }

  device {
    name = "eth0"
    type = "nic"

    properties = {
      nictype = "bridged"
      parent  = "${incus_network.code.name}"
    }
  }

  device {
    name = "data"
    type = "disk"
    properties = {
      path   = "/var/data/"
      source = incus_storage_volume.code_data.name
      pool   = incus_storage_pool.high_io.name
    }
  }
}
