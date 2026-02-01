module "acls" {
  source = "./acls"

  providers = {
    incus = incus
  }
}
