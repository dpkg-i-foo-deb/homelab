module "storage-volumes" {
  source = "./storage-volumes"

  virt_main_pool    = module.storage-pools.virt_main
  virt_high_io_pool = module.storage-pools.virt_high_io
  virt_spin0_pool   = module.storage-pools.virt_spin0

  providers = {
    incus = incus
  }
}