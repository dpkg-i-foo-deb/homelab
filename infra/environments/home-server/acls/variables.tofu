variable "homelab_cidr" {
  description = "Network CIDR where all homelab networks live"
  type        = string
  default     = "10.0.0.0/8"
}

variable "network_management_cidr" {
  description = "Privileged management CIDR where I can run Ansible for or just SSH"
  type        = string
  default     = "10.0.1.0/24"
}

variable "network_reverse_proxy_cidr" {
  description = "CIDR where reverse proxy servers live so that machines can use HTTP(S) on it"
  type        = string
  default     = "10.0.5.0/24"
}

variable "dns_server_internal_ip" {
  description = "Authorized DNS for homelab instances"
  type        = string
  default     = "10.0.2.2"
}

variable "vps_public_ip" {
  description = "VPS public IP where services like Wireguard live"
  type        = string
}
