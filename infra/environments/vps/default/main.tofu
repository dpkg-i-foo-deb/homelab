module "system_containers" {
  source = "./system-containers"

  providers = {
    incus = incus
  }
}


resource "incus_project" "default" {
  name        = "default"
  description = "Default Incus project"
  config = {
    "features.images"          = true
    "features.networks"        = true
    "features.networks.zones"  = true
    "features.profiles"        = true
    "features.storage.buckets" = true
    "features.storage.volumes" = true
  }
}
