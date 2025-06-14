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

variable "virt_main_pool" {
  type        = string
  description = "The name of the main storage pool"
}

variable "trusted_net" {
  type = object({
    name   = string
    type   = string
    config = map(string)
  })
  description = "Trusted network object"
}