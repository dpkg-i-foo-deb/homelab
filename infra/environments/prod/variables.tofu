variable "incus_token" {
  type        = string
  description = "Incus API Token"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH Public Key"
}

variable "lxc_user_password" {
  type        = string
  description = "LXC Password used for Instances"
}

variable "ansible_password" {
  type        = string
  description = "Ansible Automation Account Password"
}

variable "home_subnet" {
  type        = string
  description = "Home subnet for management"
}

variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API Token"
}

variable "security_ip" {
  type        = string
  description = "Security service address"
}
