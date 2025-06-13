module "default" {
  source = "./default"

  providers = {
    incus = incus
  }
}
