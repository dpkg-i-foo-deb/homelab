# Secrets required to configure system containers

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

# Network names to be used on system containers

variable "dns_net" {
  type = object({
    name   = string
    type   = string
    config = map(string)
  })
  description = "DNS network object"
}

variable "management_net" {
  type = object({
    name   = string
    type   = string
    config = map(string)
  })
  description = "Management network object"
}

variable "monitoring_net" {
  type = object({
    name   = string
    type   = string
    config = map(string)
  })
  description = "Monitoring network object"
}

variable "privileged_net" {
  type = object({
    name   = string
    type   = string
    config = map(string)
  })
  description = "Privileged network object"
}

variable "reverse_proxy_net" {
  type = object({
    name   = string
    type   = string
    config = map(string)
  })
  description = "Reverse Proxy network object"
}

variable "vcsoft_net" {
  type = object({
    name   = string
    type   = string
    config = map(string)
  })
  description = "vcsoft network object"
}

variable "trusted_net" {
  type = object({
    name   = string
    type   = string
    config = map(string)
  })
  description = "Trusted network object"
}

variable "untrusted_net" {
  type = object({
    name   = string
    type   = string
    config = map(string)
  })
  description = "Untrusted network object"
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

variable "virt_spin0_pool" {
  type        = string
  description = "The name of the spin0 storage pool"
}

# Storage volumes to share between system containers

variable "music_vol" {
  type        = string
  description = "The name of the music library volume"
}

variable "downloads_vol" {
  type        = string
  description = "The name of the downloads volume"
}

variable "photos_vol" {
  type        = string
  description = "The name of the photos volume"
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
