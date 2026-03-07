module "external" {
  source = "./external"

  providers = {
    incus = incus
  }

  ssh_public_key    = var.ssh_public_key
  lxc_user_password = var.lxc_user_password
  ansible_password  = var.ansible_password

  virt_main_pool = var.virt_main_pool
  reverse_proxy_net = var.reverse_proxy_net

}
