variable "mgmt_subnet" {
  type        = string
  description = "Subnet for server management"
}

variable "allowed_ssh_subnets" {
  type        = string
  description = "List of comma separated subnets to connect through SSH"
}
