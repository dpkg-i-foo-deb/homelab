# Secrets required to configure vc-cluster system containers

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