# Secrets required for my own virtual machines

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

# Secrets required to configure vc-cluster virtual machines

variable "vc_cluster_ssh_public_key" {
  type        = string
  description = "The SSH public key to inject into vc-cluster containers."
}

variable "vc_cluster_lxc_user_password" {
  type        = string
  description = "The default password for the vc-cluster lxc user."
  sensitive   = true
}

variable "vc_cluster_ansible_password" {
  type        = string
  description = "The default password for the vc-cluster ansible user."
  sensitive   = true
}

# Subnets to allow special connections

variable "management_subnet" {
  type        = string
  description = "Management subnet to allow SSH and other connections from"
}

variable "management_net" {
  type = object({
    name   = string
    type   = string
    config = map(string)
  })
  description = "The name of the management network"
}

variable "untrusted_net" {
  type = object({
    name   = string
    type   = string
    config = map(string)
  })
  description = "Untrusted network object"
}

variable "reverse_proxy_net" {
  type = object({
    name   = string
    type   = string
    config = map(string)
  })
  description = "Reverse Proxy network object"
}
# Storage pools available for system containers

variable "virt_main_pool" {
  type        = string
  description = "The name of the main storage pool"
}

variable "virt_high_io_pool" {
  type        = string
  description = "The name of the high I/O storage pool"
}
