resource "incus_storage_pool" "virt_spin0" {
  name   = "virt-spin0"
  driver = "lvm"
}
