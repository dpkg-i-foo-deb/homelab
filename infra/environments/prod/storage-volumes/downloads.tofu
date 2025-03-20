resource "incus_storage_volume" "downloads" {
  name = "downloads"
  pool = module.storage_pools.virt_spin_usb
  config = {
    "size" = "200GiB"
  }
}