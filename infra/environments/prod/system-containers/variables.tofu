variable "ssh_public_key" {
  type        = string
  description = "The SSH public key to inject into containers."
}

variable "lxc_user_password" {
  type        = string
  description = "The default password for the lxc user."
  sensitive   = true
}

variable "ansible_password" {
  type        = string
  description = "The default password for the ansible user."
  sensitive   = true
}
