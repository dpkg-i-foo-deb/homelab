# Default project

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

# vc-cluster project

variable "vc_cluster_ssh_public_key" {
  type        = string
  description = "vc-cluster SSH public key"
}

variable "vc_cluster_lxc_user_password" {
  type        = string
  description = "vc-cluster LXC user password"
}

variable "vc_cluster_ansible_password" {
  type        = string
  description = "vc-cluster Ansible password"
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

variable "hypervisor_address" {
  type        = string
  description = "IP Address to access the hypervisor"
}
