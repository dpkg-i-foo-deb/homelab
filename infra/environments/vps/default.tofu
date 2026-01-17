module "default" {
  source = "./default"

  providers = {
    incus = incus
  }

  ansible_password  = var.ansible_password
  lxc_user_password = var.lxc_user_password
  ssh_public_key    = var.ssh_public_key

  virt_main_pool = module.storage_pools.virt_main

  trusted_net = module.networks.trusted
  dmz_net     = module.networks.dmz
}
