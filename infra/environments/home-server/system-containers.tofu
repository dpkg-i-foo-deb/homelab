module "system-containers" {
  source = "./system-containers"

  lxc_user_password = var.lxc_user_password
  ssh_public_key    = var.ssh_public_key
  ansible_password  = var.ansible_password

  management_subnet = var.home_subnet

  dns_net           = module.networks.dns
  privileged_net    = module.networks.privileged
  reverse_proxy_net = module.networks.reverse_proxy
  vcsoft_net        = module.networks.vcsoft
  torrenting_net    = module.networks.torrenting
  trusted_net       = module.networks.trusted
  untrusted_net     = module.networks.untrusted
  management_net    = module.networks.management
  monitoring_net    = module.networks.monitoring
  work_net          = module.networks.work

  virt_main_pool    = module.storage-pools.virt_main
  virt_high_io_pool = module.storage-pools.virt_high_io
  virt_spin0_pool   = module.storage-pools.virt_spin0

  music_vol     = module.storage-volumes.music
  downloads_vol = module.storage-volumes.downloads
  photos_vol    = module.storage-volumes.photos

  vc_cluster_ssh_public_key    = var.vc_cluster_ssh_public_key
  vc_cluster_lxc_user_password = var.vc_cluster_lxc_user_password
  vc_cluster_ansible_password  = var.vc_cluster_ansible_password

  providers = {
    incus = incus
  }
}
