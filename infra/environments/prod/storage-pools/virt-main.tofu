resource "incus_storage_pool" "virt_main" {
  name   = "virt-main"
  driver = "lvm"
}