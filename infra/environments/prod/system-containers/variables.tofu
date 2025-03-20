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

# Network names to be used on system containers

variable "dns_net" {
  type = string
  description = "The name of the DNS network"
}

variable "code_net" {
  type = string
  description = "The name of the Coding network"
}

variable "privileged_net" {
  type = string
  description = "The name of the Privileged network"
}

variable "reverse_proxy_net" {
  type = string
  description = "The name of the Reverse Proxy network"
}

variable "storage_net" {
  type = string
  description = "The name of the Storage network"
}

variable "torrenting_net" {
  type = string
  description = "The name of the Torrenting network"
}

variable "trusted_net" {
  type = string
  description = "The name of the Trusted network"
}

variable "untrusted_net" {
  type = string
  description = "The name of the Untrusted network"
}

# Storage pools available for system containers

variable "virt_main_pool" {
  type = string
  description = "The name of the main storage pool"
}

variable "virt_high_io_pool" {
  type = string
  description = "The name of the high I/O storage pool"
}

variable "virt_spin_usb_pool" {
  type = string
  description = "The name of the HDD USB storage pool"
}

