data "github_ip_ranges" "ranges" {}
data "cloudflare_ip_ranges" "ranges" {}

module "acls" {
  source = "./acls"

  mgmt_subnet         = var.home_subnet
  allowed_ssh_subnets = join(",", data.github_ip_ranges.ranges.git)
  allowed_dns_subnets = join(",", data.cloudflare_ip_ranges.ranges.ipv4_cidr_blocks)

  providers = {
    incus = incus
  }
}

module "networks" {
  source = "./networks"

  external_dns_acl = module.acls.external_dns
  internal_dns_acl = module.acls.internal_dns
  inbound_dns_acl  = module.acls.inbound_dns
  http_acl         = module.acls.http
  http_inbound_acl = module.acls.http_inbound
  ssh_mgmt_acl     = module.acls.ssh_mgmt
  ssh_outbound_acl = module.acls.ssh_outbound

  providers = {
    incus = incus
  }
}

module "storage-pools" {
  source = "./storage-pools"

  providers = {
    incus = incus
  }
}

module "storage-volumes" {
  source = "./storage-volumes"

  virt_main_pool     = module.storage-pools.virt_main
  virt_high_io_pool  = module.storage-pools.virt_high_io
  virt_spin_usb_pool = module.storage-pools.virt_spin_usb

  providers = {
    incus = incus
  }
}

module "system-containers" {
  source = "./system-containers"

  lxc_user_password = var.lxc_user_password
  ssh_public_key    = var.ssh_public_key
  ansible_password  = var.ansible_password

  management_subnet = var.home_subnet

  dns_net           = module.networks.dns
  code_net          = module.networks.code
  privileged_net    = module.networks.privileged
  reverse_proxy_net = module.networks.reverse_proxy
  storage_net       = module.networks.storage
  torrenting_net    = module.networks.torrenting
  trusted_net       = module.networks.trusted
  untrusted_net     = module.networks.untrusted

  virt_main_pool     = module.storage-pools.virt_main
  virt_high_io_pool  = module.storage-pools.virt_high_io
  virt_spin_usb_pool = module.storage-pools.virt_spin_usb

  music_vol     = module.storage-volumes.music
  downloads_vol = module.storage-volumes.downloads


  providers = {
    incus = incus
  }
}
