resource "incus_storage_volume" "music" {
  name = "music"
  pool = var.virt_spin_usb_pool
  project = "default"
  config = {
    "size" = "700GiB"
  }
}