resource "incus_storage_pool" "virt_spin_usb" {
  name = "virt-spin-usb"
  driver = "lvm"
}
