resource "incus_storage_volume" "music" {
  name = "music"
  pool = var.virt_spin0_pool
  project = "default"
  config = {
    "size" = "700GiB"
  }
}