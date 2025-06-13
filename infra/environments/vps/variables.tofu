variable "vps_address" {
  type        = string
  description = "IPV4 for my VPS"
}

variable "incus_token" {
  type        = string
  description = "Token to issue certificates for the Incus server"
}
