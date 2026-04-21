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
