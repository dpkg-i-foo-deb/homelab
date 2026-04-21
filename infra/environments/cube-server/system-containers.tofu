module "system-containers" {
  source = "./system-containers"

  lxc_user_password = var.lxc_user_password
  ssh_public_key    = var.ssh_public_key
  ansible_password  = var.ansible_password

  dns_net           = module.networks.dns
  reverse_proxy_net = module.networks.reverse_proxy
  trusted_net       = module.networks.trusted
  untrusted_net     = module.networks.untrusted
  management_net    = module.networks.management
  torrent_net       = module.networks.torrent
  transit_net       = module.networks.transit
  monitoring_net    = module.networks.monitoring

  virt_main_pool    = module.storage-pools.virt_main

  music_vol     = module.storage-volumes.music
  downloads_vol = module.storage-volumes.downloads
  photos_vol    = module.storage-volumes.photos

  providers = {
    incus = incus
  }
}
