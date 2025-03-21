output "external_dns" {
  value       = incus_network_acl.external_dns.name
  description = "ACL to allow access to external DNS services"
}

output "internal_dns" {
  value       = incus_network_acl.internal_dns.name
  description = "ACL to allow access to internal DNS services"
}

output "http" {
  value       = incus_network_acl.http.name
  description = "ACL to allow access to HTTP services"
}

output "ssh_mgmt" {
  value       = incus_network_acl.ssh_mgmt.name
  description = "ACL to allow inbound management SSH connections"
}
