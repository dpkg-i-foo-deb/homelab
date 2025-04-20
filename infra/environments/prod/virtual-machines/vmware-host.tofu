# resource "incus_storage_volume" "vmware_host_data" {
#   name    = "vmware_host_data"
#   pool    = var.virt_high_io_pool
#   project = "default"
#   config = {
#     "size" = "100GiB"
#   }
# }

# resource "incus_instance" "vmware_host" {
#   name  = "vmware-host"
#   type    = "virtual-machine"
#   image = "images:debian/trixie/cloud"

#   config = {
#     "boot.autostart" = true
#     "limits.cpu"     = 4
#     "limits.memory"  = "12GiB"
#     # "limits.memory.swap"          = "true"
#     # "limits.memory.swap.priority" = "0"
#     "cloud-init.user-data" = templatefile(
#       "${path.module}/cloud-init/generic.yml.tftpl",
#       {
#         ssh_public_key           = var.ssh_public_key
#         lxc_username             = "vmware-host"
#         lxc_username_description = "Host to run VMWare in"
#         lxc_user_password        = var.lxc_user_password
#         ansible_password         = var.ansible_password
#       }
#     )
#   }

#   device {
#     name = "eth0"
#     type = "nic"
#     properties = {
#       network        = var.untrusted_net.name
#       "ipv4.address" = "10.0.8.16"
#     }
#   }

#   device {
#     name = "root"
#     type = "disk"
#     properties = {
#       path = "/"
#       pool = var.virt_high_io_pool
#       size = "50GiB"
#     }
#   }

#   device {
#     name = "data"
#     type = "disk"
#     properties = {
#       path   = "/home"
#       source = incus_storage_volume.vmware_host_data.name
#       pool   = var.virt_high_io_pool
#     }
#   }
# }



