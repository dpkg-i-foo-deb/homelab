module "default" {
  source = "./default"

  providers = {
    incus = incus
  }

  virt_main_pool = module.storage-pools.virt_main
}
