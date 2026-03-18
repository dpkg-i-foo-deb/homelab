module "storage-pools" {
  source = "./storage-pools"

  providers = {
    incus = incus
  }
}