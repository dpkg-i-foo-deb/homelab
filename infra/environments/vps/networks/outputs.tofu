output "trusted" {
  value       = incus_network.trusted
  description = "Network where trusted services live"
}

output "dmz" {
  value = incus_network.dmz
  description = "Network where public facing services are hosted"
}

output "transit" {
  value = incus_network.transit
  description = "Network for transit services"
}