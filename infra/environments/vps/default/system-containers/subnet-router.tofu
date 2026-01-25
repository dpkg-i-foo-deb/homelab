resource "incus_storage_volume" "subnet_router_data" {
  name    = "subnet-router-data"
  pool    = var.virt_main_pool
  project = "default"
  config = {
    size = "1GiB"
  }
}

# resource "incus_instance" "subnet_router" {
#   name  = "subnet-router"
#   image = "images:debian/trixie/cloud"

#   config = {
#     "boot.autostart"              = true
#     "limits.cpu"                  = 1
#     "limits.memory"               = "512MiB"
#     "limits.memory.swap"          = "true"
#     "limits.memory.swap.priority" = "0"
#     "cloud-init.user-data" = templatefile(
#       "${path.root}/cloud-init/generic.yml.tftpl",
#       {
#         ssh_public_key           = var.ssh_public_key,
#         lxc_username             = "subnet-router"
#         lxc_username_description = "subnet-router Linux System Container"
#         lxc_user_password        = var.lxc_user_password,
#         ansible_password         = var.ansible_password
#       }
#     )
#     "security.nesting" = true
#   }
#   device {
#     name = "eth0"
#     type = "nic"
#     properties = {
#       network        = var.trusted_net.name
#       "ipv4.address" = "10.0.254.6"
#     }
#   }

#   device {
#     name = "eth1"
#     type = "nic"
#     properties = {
#       network = var.dmz_net.name
#       "ipv4.address" = "10.0.253.5"
#     }
#   }

#   device {
#     name = "root"
#     type = "disk"
#     properties = {
#       path = "/"
#       pool = var.virt_main_pool
#       size = "2GiB"
#     }
#   }

#   device {
#     name = "data"
#     type = "disk"
#     properties = {
#       path   = "/home"
#       source = incus_storage_volume.subnet_router_data.name
#       pool   = var.virt_main_pool
#     }
#   }

# }


