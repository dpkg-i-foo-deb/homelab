resource "incus_storage_volume" "music" {
  name = "music"
  pool = module.storage_pools.virt_spin_usb
  config = {
    "size" = "700GiB"
  }
}