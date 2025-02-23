terraform {
  required_providers {
    incus = {
      source  = "lxc/incus"
      version = "0.2.0"
    }
  }
}

provider "incus" {
  generate_client_certificates = true
  accept_remote_certificate    = true

  remote {
    name    = "hypervisor"
    scheme  = "https"
    address = "10.0.0.11"
    token   = var.incus_token
    default = true
  }

}
