resource "incus_storage_volume" "music" {
  name = "music"
  pool = var.virt_main_pool
  project = "default"
  config = {
    "size" = "500GiB"
  }
}