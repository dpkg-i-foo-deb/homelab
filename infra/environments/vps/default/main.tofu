module "system_containers" {
  source = "./system-containers"

  providers = {
    incus = incus
  }

  virt_main_pool = var.virt_main_pool
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
