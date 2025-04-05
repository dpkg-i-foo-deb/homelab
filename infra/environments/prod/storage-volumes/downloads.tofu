resource "incus_storage_volume" "downloads" {
  name = "downloads"
  pool = var.virt_spin0_pool
  project = "default"
  config = {
    "size" = "200GiB"
  }
}