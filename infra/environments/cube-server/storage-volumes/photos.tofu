resource "incus_storage_volume" "photos" {
  name    = "photos"
  pool    = var.virt_main_pool
  project = "default"
  config = {
    "size" = "500GiB"
  }
}
