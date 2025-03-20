terraform {
  required_providers {
    incus = {
      source  = "lxc/incus"
      version = "0.3.0"
    }
  }
}

module "networks" {
  source = "../networks"
}

module "storage_pools" {
  source = "../storage-pools"
}

module "storage_volumes" {
  source = "../storage-volumes"
}
