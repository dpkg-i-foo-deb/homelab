module "storage-volumes" {
  source = "./storage-volumes"

  virt_main_pool    = module.storage-pools.virt_main

  providers = {
    incus = incus
  }
}