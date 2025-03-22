output "dns" {
  value       = incus_network.dns.name
  description = "The name of the DNS network"
}

output "code" {
  value       = incus_network.code.name
  description = "The name of the Code network"
}

output "privileged" {
  value       = incus_network.privileged.name
  description = "The name of the Privileged network"
}

output "reverse_proxy" {
  value       = incus_network.reverse_proxy.name
  description = "The name of the Privileged network"
}

output "storage" {
  value       = incus_network.storage.name
  description = "The name of the Storage network"
}

output "torrenting" {
  value       = incus_network.torrenting.name
  description = "The name of the Torrenting network"
}

output "trusted" {
  value       = incus_network.trusted.name
  description = "The name of the Trusted network"
}

output "untrusted" {
  value       = incus_network.untrusted.name
  description = "The name of the Untrusted network"
}

output "incusbr0" {
  value       = incus_network.incusbr0.name
  description = "The name of the uplink incusbr0 network"
}
