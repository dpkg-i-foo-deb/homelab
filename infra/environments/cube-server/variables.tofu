# Default project

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

variable "vps_public_ip" {
  type        = string
  description = "Public IP address of my VPS"
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
