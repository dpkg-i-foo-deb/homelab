resource "incus_storage_pool" "main" {
  name   = "main"
  driver = "btrfs"
}

resource "incus_storage_pool" "high_io" {
  name   = "high_io"
  driver = "btrfs"
}
