output "dns" {
  value       = incus_network.dns
  description = "Internal DNS services network"
}

output "management" {
  value       = incus_network.management
  description = "Bastion and other services network"
}

output "monitoring" {
  value       = incus_network.monitoring
  description = "Monitoring services network"
}

output "reverse_proxy" {
  value       = incus_network.reverse_proxy
  description = "Network for reverse proxy services"
}

output "vcsoft" {
  value       = incus_network.vcsoft
  description = "Network for VC services"
}

output "trusted" {
  value       = incus_network.trusted
  description = "Network where trusted services live"
}

output "untrusted" {
  value       = incus_network.untrusted
  description = "Network for services I don't entirely trust"
}