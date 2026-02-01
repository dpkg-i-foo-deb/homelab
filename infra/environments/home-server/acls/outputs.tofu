output "base" {
  value       = incus_network_acl.base.name
  description = "Base ACL that allows machines to work"
}

output "drop" {
  value       = incus_network_acl.drop
  description = "ACL to kill everything"
}

output "management_ingress" {
  value       = incus_network_acl.management_ingress
  description = "ACL to allow management machines to do their thing"
}

output "reverse_proxy" {
  value       = incus_network_acl.reverse_proxy
  description = "ACL for reverse proxies"
}

output "vpn_gateway" {
  value       = incus_network_acl.vpn_gateway
  description = "ACL for VPN Gateways"
}

output "web_client" {
  value       = incus_network_acl.web_client
  description = "ACL for web clients"
}
