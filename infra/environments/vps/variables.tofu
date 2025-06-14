variable "vps_address" {
  type        = string
  description = "IPV4 for my VPS"
}

variable "lxc_user_password" {
  type        = string
  description = "Password for LXC users"
}

variable "ansible_password" {
  type        = string
  description = "Password for Ansible"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key to connect to instances"
}

variable "incus_token" {
  type        = string
  description = "Token to issue certificates for the Incus server"
}
