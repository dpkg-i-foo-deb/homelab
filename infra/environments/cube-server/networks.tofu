module "networks" {
  source = "./networks"

  providers = {
    incus = incus
  }
}
