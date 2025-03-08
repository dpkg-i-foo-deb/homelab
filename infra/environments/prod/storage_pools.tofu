resource "incus_storage_pool" "virt-main" {
  name   = "virt-main"
  driver = "lvm"
}

resource "incus_storage_pool" "virt-high-io" {
  name   = "virt-high-io"
  driver = "lvm"
}

resource "incus_storage_pool" "virt-spin-usb" {
  name = "virt-spin-usb"
  driver = "lvm"
}
