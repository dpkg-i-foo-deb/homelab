
# resource "incus_network_acl" "gaming_svc" {
#   name = "gaming-svc"

#   ingress = [
#     {
#       action = "allow"
#       source = join(",",
#         [
#           var.management_subnet,
#           var.reverse_proxy_net.config["ipv4.address"]
#       ])
#       destination_port = "47990,47984,47989,48010"
#       protocol         = "tcp"
#       description      = "Allow incoming connections to Sunshine (TCP)"
#       state            = "enabled"
#     },
#     {
#       action = "allow"
#       source = join(",",
#         [
#           var.management_subnet,
#           var.reverse_proxy_net.config["ipv4.address"]
#       ])
#       destination_port = "47998-48000"
#       protocol         = "udp"
#       description      = "Allow incoming connections to Sunshine (UDP)"
#       state            = "enabled"
#     }
#   ]

#   egress = [
#     {
#       action = "allow"
#       #Main terraria server
#       destination      = "10.0.8.11/32"
#       destination_port = "7777"
#       protocol         = "tcp"
#       description      = "Allow outgoing connections to Terraria server(s)"
#       state            = "enabled"
#     }
#   ]
# }

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
#         "security.acls" = join(",",
#           [
#             incus_network_acl.gaming_svc.name
#         ])
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
