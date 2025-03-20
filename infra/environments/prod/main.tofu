module "networks" {
  source = "./networks"
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
  providers = {
    incus = incus
  }
}

module "system-containers" {
  source = "./system-containers"
  lxc_user_password = var.lxc_user_password
  ssh_public_key = var.ssh_public_key
  ansible_password = var.ansible_password

  dns_net = module.networks.dns
  code_net = module.networks.code
  privileged_net = module.networks.privileged
  reverse_proxy_net = module.networks.reverse_proxy
  storage_net = module.networks.storage
  torrenting_net = module.networks.torrenting
  trusted_net = module.networks.trusted
  untrusted_net = module.networks.untrusted

  virt_main_pool = module.storage-pools.virt_main
  virt_high_io_pool = module.storage-pools.virt_high_io
  virt_spin_usb_pool = module.storage-pools.virt_spin_usb

  providers = {
    incus = incus
  }
}
