module "vc" {
  source = "./vc"

  providers = {
    incus = incus
  }

  ssh_public_key    = var.vc_cluster_ssh_public_key
  lxc_user_password = var.vc_cluster_lxc_user_password
  ansible_password  = var.vc_cluster_ansible_password

  untrusted_net     = var.untrusted_net
  virt_main_pool    = var.virt_main_pool
  virt_high_io_pool = var.virt_high_io_pool

}
