variable "mgmt_subnets" {
  type        = string
  description = "Subnets for server management"
}

variable "allowed_ssh_subnets" {
  type        = string
  description = "List of comma separated subnets to connect through SSH"
}

variable "allowed_dns_subnets" {
  type        = string
  description = "List of comma separated subnets to make DNS requests to"
}

variable "security_ip" {
  type        = string
  description = "Security service address"
}