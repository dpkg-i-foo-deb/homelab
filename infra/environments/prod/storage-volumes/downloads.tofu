resource "incus_storage_volume" "downloads" {
  name = "downloads"
  pool = var.virt_spin_usb_pool
  project = "default"
  config = {
    "size" = "200GiB"
  }
}