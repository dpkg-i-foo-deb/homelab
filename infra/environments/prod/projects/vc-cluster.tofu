resource "incus_project" "vc_cluster" {
  name        = "vc-cluster"
  description = "VC Cluster machines"
  config = {
    "features.storage.volumes" = false
    "features.images"          = false
    "features.profiles"        = false
    "features.storage.buckets" = false
    "features.networks"        = false
    "features.networks.zones"  = false
  }
}
