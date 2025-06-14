module "default" {
  source = "./default"

  providers = {
    incus = incus
  }

  virt_main_pool = module.storage_pools.virt_main
}
