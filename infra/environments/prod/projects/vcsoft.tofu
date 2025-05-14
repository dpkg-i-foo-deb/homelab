resource "incus_project" "vcsoft" {
  name        = "vcsoft"
  description = "VCSOFT Machines"
  config = {
    "features.storage.volumes" = false
    "features.images"          = false
    "features.profiles"        = false
    "features.storage.buckets" = false
    "features.networks"        = false
    "features.networks.zones"  = false
  }
}
