terraform {
    required_providers {
      incus = {
        source = "lxc/incus"
        version = "0.3.1"
      }
    }
}

provider "incus" {
  generate_client_certificates = true
  accept_remote_certificate    = true

  remote {
    name    = "vps"
    scheme  = "https"
    address = var.vps_address
    token   = var.incus_token
    default = true
  }
}