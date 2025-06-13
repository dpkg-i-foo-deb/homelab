resource "incus_storage_pool" "virt_high_io" {
  name   = "virt-high-io"
  driver = "lvm"
}