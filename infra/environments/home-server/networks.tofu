module "networks" {
  source = "./networks"

  external_dns_acl         = module.acls.external_dns
  internal_dns_acl         = module.acls.internal_dns
  inbound_dns_acl          = module.acls.inbound_dns
  http_acl                 = module.acls.http
  http_inbound_acl         = module.acls.http_inbound
  ssh_mgmt_acl             = module.acls.ssh_mgmt
  ssh_outbound_acl         = module.acls.ssh_outbound
  tailscale_inbound_acl    = module.acls.tailscale_inbound
  rdp_inbound_acl          = module.acls.rdp_inbound
  dchp_outbound_acl        = module.acls.dchp_outbound


  providers = {
    incus = incus
  }
}
