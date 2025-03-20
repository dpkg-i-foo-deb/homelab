terraform {
  required_providers {
    incus = {
      source  = "lxc/incus"
      version = "0.3.0"
    }
  }
}

module "storage_pools" {
  source = "../storage-pools"
}
