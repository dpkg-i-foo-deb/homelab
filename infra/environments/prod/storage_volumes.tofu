resource "incus_storage_volume" "downloads" {
  name = "downloads"
  pool = incus_storage_pool.virt-spin-usb.name
  config = {
    "size" = "200GiB"
  }
}

resource "incus_storage_volume" "music" {
  name = "music"
  pool = incus_storage_pool.virt-spin-usb.name
  config = {
    "size" = "700GiB"
  }
}
