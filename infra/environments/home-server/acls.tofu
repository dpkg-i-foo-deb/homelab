module "acls" {
  source = "./acls"

  vps_public_ip = var.vps_public_ip

  providers = {
    incus = incus
  }
}
