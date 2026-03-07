resource "incus_storage_volume" "downloads" {
  name = "downloads"
  pool = var.virt_main_pool
  project = "default"
  config = {
    "size" = "100GiB"
  }
}
