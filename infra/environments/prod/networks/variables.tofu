variable "external_dns_acl" {
  type        = string
  description = "ACL to allow external DNS connections"
}

variable "internal_dns_acl" {
  type        = string
  description = "ACL to allow DNS connections to internal servers"
}

variable "http_acl" {
  type        = string
  description = "ACL to allow HTTP connections"
}

variable "ssh_mgmt_acl" {
  type        = string
  description = "ACL to allow inbound SSH connections for management"
}
