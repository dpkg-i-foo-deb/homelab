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
  default_remote = "cube"

  remote {
    name    = "cube"
    address = "https://10.0.1.1:8443"
  }
}

