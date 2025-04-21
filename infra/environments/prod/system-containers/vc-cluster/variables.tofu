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

variable "untrusted_net" {
  type = object({
    name   = string
    type   = string
    config = map(string)
  })
  description = "Untrusted network object"
}

variable "virt_main_pool" {
  type        = string
  description = "The name of the main storage pool"
}

variable "virt_high_io_pool" {
  type        = string
  description = "The name of the high I/O storage pool"
}