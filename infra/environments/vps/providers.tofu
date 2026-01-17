terraform {
    required_providers {
      incus = {
        source = "lxc/incus"
        version = "1.0.2"
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