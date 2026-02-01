
# resource "incus_instance" "gaming" {
#   name    = "gaming"
#   image   = "images:debian/bookworm/cloud"
#   running = true

#   config = {
#     "boot.autostart" = false
#     "limits.cpu"     = 6
#     "limits.memory"  = "16GiB"
#     "cloud-init.user-data" = templatefile(
#       "${path.root}/cloud-init/generic.yml.tftpl",
#       {
#         ssh_public_key           = var.ssh_public_key
#         lxc_username             = "gaming"
#         lxc_username_description = "Gaming System Container"
#         lxc_user_password        = var.lxc_user_password
#         ansible_password         = var.ansible_password
#       }
#     )
#     "security.nesting" = true
#     # "raw.qemu.conf" : "[device \"qemu_gpu\"]"
#   }

#   device {
#     name = "gpu"
#     type = "gpu"
#     properties = {
#       pci = "01:00.0"
#       gid = "44"
#     }
#   }

#   device {
#     name = "uinput"
#     type = "unix-char"
#     properties = {
#       path = "/dev/uinput"
#       mode = "0666"
#     }
#   }

#   device {
#     name = "uhid"
#     type = "unix-char"
#     properties = {
#       path = "/dev/uhid"
#       mode = "0666"
#     }
#   }


#   device {
#     name = "eth0"
#     type = "nic"
#     properties = {
#       network        = var.untrusted_net.name
#       "ipv4.address" = "10.0.8.15"
#     }
#   }
#   device {
#     name = "root"
#     type = "disk"
#     properties = {
#       path   = "/"
#       pool   = var.virt_high_io_pool
#       "size" = "50GiB"
#     }
#   }


# }
