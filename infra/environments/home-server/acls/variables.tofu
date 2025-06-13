variable "incus_addresses" {
  type        = string
  description = "IP Addresses to access the hypervisor Incus API"
}

variable "mgmt_subnets" {
  type        = string
  description = "Subnets for server management"
}

variable "allowed_ssh_subnets" {
  type        = string
  description = "List of comma separated subnets to connect through SSH"
}
