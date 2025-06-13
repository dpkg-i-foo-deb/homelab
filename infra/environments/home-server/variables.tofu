# Default project

variable "incus_token" {
  type        = string
  description = "Incus API Token"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH Public Key"
}

variable "security_ip" {
  type        = string
  description = "Security service address"
}

variable "vps_addresses" {
  type        = list(string)
  description = "List of IP Addresses to access VPS servers"
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
