resource "incus_storage_volume" "games" {
  name = "games"
  pool = var.virt_high_io_pool
  project = "default"
  config = {
    "size" = "200GiB"
  }
}