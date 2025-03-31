variable "external_dns_acl" {
  type        = string
  description = "ACL to allow external DNS connections"
}

variable "internal_dns_acl" {
  type        = string
  description = "ACL to allow DNS connections to internal servers"
}

variable "inbound_dns_acl" {
  type        = string
  description = "ACL to allow inbound DNS connections"
}

variable "http_acl" {
  type        = string
  description = "ACL to allow HTTP connections"
}

variable "http_inbound_acl" {
  type        = string
  description = "ACL to allow inbound HTTP connections"
}

variable "ssh_mgmt_acl" {
  type        = string
  description = "ACL to allow inbound SSH connections for management"
}

variable "ssh_outbound_acl" {
  type        = string
  description = "ACL to allow outbound SSH connections"
}

variable "wazuh_security_acl" {
  type        = string
  description = "ACL to allow access to Wazuh server"
}

variable "incus_api_outbound_acl" {
  type        = string
  description = "ACL to allow outbound Incus API connections"
}
