output "external_dns" {
  value       = incus_network_acl.external_dns.name
  description = "ACL to allow access to external DNS services"
}

output "internal_dns" {
  value       = incus_network_acl.internal_dns.name
  description = "ACL to allow access to internal DNS services"
}

output "inbound_dns" {
  value       = incus_network_acl.inbound_dns.name
  description = "ACL to allow inbound DNS connections"
}

output "http" {
  value       = incus_network_acl.http.name
  description = "ACL to allow access to HTTP services"
}

output "http_inbound" {
  value       = incus_network_acl.http_inbound.name
  description = "ACL to allow inbound HTTP connections"
}

output "ssh_mgmt" {
  value       = incus_network_acl.ssh_mgmt.name
  description = "ACL to allow inbound management SSH connections"
}

output "ssh_outbound" {
  description = "ACL to allow outbound SSH connections"
  value       = incus_network_acl.ssh_outbound.name
}

output "tailscale_inbound" {
  value       = incus_network_acl.tailscale_inbound.name
  description = "ACL to allow Tailscale functionality"
}


output "rdp_inbound" {
  value       = incus_network_acl.rdp_inbound.name
  description = "ACL to allow inbound RDP connections"
}

output "dchp_outbound" {
  value       = incus_network_acl.dchp_outbound.name
  description = "ACL to allow outbound DHCP connections"
}
