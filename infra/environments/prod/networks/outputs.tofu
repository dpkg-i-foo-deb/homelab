output "dns_net" {
  value       = incus_network.dns.name
  description = "The name of the DNS network"
}

output "code_net" {
  value       = incus_network.code.name
  description = "The name of the Code network"
}

output "privileged_net" {
  value       = incus_network.privileged.name
  description = "The name of the Privileged network"
}

output "reverse_proxy_net" {
  value       = incus_network.privileged.name
  description = "The name of the Privileged network"
}

output "storage_net" {
  value       = incus_network.storage.name
  description = "The name of the Storage network"
}

output "torrenting_net" {
  value       = incus_network.torrenting.name
  description = "The name of the Torrenting network"
}

output "trusted_net" {
  value       = incus_network.trusted.name
  description = "The name of the Trusted network"
}

output "untrusted_net" {
  value       = incus_network.untrusted.name
  description = "The name of the Untrusted network"
}