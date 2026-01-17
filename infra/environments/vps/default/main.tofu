module "system_containers" {
  source = "./system-containers"

  providers = {
    incus = incus
  }

  virt_main_pool = var.virt_main_pool

  trusted_net = var.trusted_net
  dmz_net     = var.dmz_net

  ansible_password  = var.ansible_password
  lxc_user_password = var.lxc_user_password
  ssh_public_key    = var.ssh_public_key
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
