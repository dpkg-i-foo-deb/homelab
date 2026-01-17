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
  default_remote = "vps"

  remote {
    name    = "vps"
    address = "https://${var.incus_token}:8443"
    token   = var.incus_token
  }
}