terraform {
  required_providers {
    incus = {
      source  = "lxc/incus"
      version = "0.3.0"
    }
    github = {
      source  = "integrations/github"
      version = "6.6.0"
    }
  }
}
