module "virtual-machines" {
  source = "./virtual-machines"

  providers = {
    incus = incus
  }

  lxc_user_password = var.lxc_user_password
  ssh_public_key    = var.ssh_public_key
  ansible_password  = var.ansible_password

  management_subnet = var.home_subnet

  vc_cluster_ssh_public_key    = var.vc_cluster_ssh_public_key
  vc_cluster_lxc_user_password = var.vc_cluster_lxc_user_password
  vc_cluster_ansible_password  = var.vc_cluster_ansible_password

  virt_main_pool    = module.storage-pools.virt_main
  virt_high_io_pool = module.storage-pools.virt_high_io

  management_net = module.networks.management
  untrusted_net  = module.networks.untrusted
  reverse_proxy_net = module.networks.reverse_proxy
}
