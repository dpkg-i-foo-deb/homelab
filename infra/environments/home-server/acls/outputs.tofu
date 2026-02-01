output "base" {
  value       = incus_network_acl.base.name
  description = "Base ACL that allows machines to work"
}

output "management_ingress" {
  value       = incus_network_acl.management_ingress.name
  description = "ACL to allow management machines to do their thing"
}

output "reverse_proxy" {
  value       = incus_network_acl.reverse_proxy.name
  description = "ACL for reverse proxies"
}

output "vpn_gateway" {
  value       = incus_network_acl.vpn_gateway.name
  description = "ACL for VPN Gateways"
}

output "web_client" {
  value       = incus_network_acl.web_client.name
  description = "ACL for web clients"
}
