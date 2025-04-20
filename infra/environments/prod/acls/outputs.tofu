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

output "wazuh_security" {
  value       = incus_network_acl.wazuh_security.name
  description = "ACL to allow access to Wazuh server"
}

output "incus_api_outbound" {
  value       = incus_network_acl.incus_api_outbound.name
  description = "ACL to allow outbound Incus API connections"
}

output "tailscale_inbound" {
  value       = incus_network_acl.tailscale_inbound.name
  description = "ACL to allow Tailscale functionality"
}

output "torrenting" {
  value       = incus_network_acl.torrenting.name
  description = "ACL to allow inbound torrenting connections"
}

output "rdp_inbound" {
  value       = incus_network_acl.rdp_inbound.name
  description = "ACL to allow inbound RDP connections"
}
