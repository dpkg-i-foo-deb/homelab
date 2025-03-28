terraform {
  required_providers {
    incus = {
      source  = "lxc/incus"
      version = "0.2.0"
    }
    github = {
      source  = "integrations/github"
      version = "6.6.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.35.0"
    }
  }
}

provider "incus" {
  generate_client_certificates = true
  accept_remote_certificate    = true

  remote {
    name    = "hypervisor"
    scheme  = "https"
    address = "192.168.8.4"
    token   = var.incus_token
    default = true
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
