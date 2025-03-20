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
  providers = {
    incus = incus
  }
}
