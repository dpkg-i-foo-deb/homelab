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

# Subnets to allow special connections

variable "management_subnet" {
  type        = string
  description = "Management subnet to allow SSH and other connections from"
}

variable "external_net" {
  type = object({
    name   = string
    type   = string
    config = map(string)
  })
  description = "Untrusted network object"
}

variable "virt_high_io_pool" {
  type        = string
  description = "The name of the high I/O storage pool"
}
