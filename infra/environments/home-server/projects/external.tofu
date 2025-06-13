resource "incus_project" "external" {
  name        = "external"
  description = "External services for friends"
  config = {
    "features.storage.volumes" = false
    "features.images"          = false
    "features.profiles"        = false
    "features.storage.buckets" = false
    "features.networks"        = false
    "features.networks.zones"  = false
  }
}
