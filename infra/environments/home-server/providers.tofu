terraform {
  required_providers {
    incus = {
      source  = "lxc/incus"
      version = "1.0.2"
    }
    github = {
      source  = "integrations/github"
      version = "6.6.0"
    }
  }
}

provider "incus" {
  generate_client_certificates = true
  accept_remote_certificate    = true
  default_remote = "hypervisor"

  remote {
    name    = "hypervisor"
    address = "https://192.168.8.4:8443"
    token   = var.incus_token
  }
}

