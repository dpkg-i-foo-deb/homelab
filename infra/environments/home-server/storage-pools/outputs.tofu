output "virt_high_io" {
  value       = incus_storage_pool.virt_high_io.name
  description = "The name of the high io storage pool"
}

output "virt_main" {
  value       = incus_storage_pool.virt_main.name
  description = "The name of the main storage pool"
}

output "virt_spin0" {
  value       = incus_storage_pool.virt_spin0.name
  description = "The name of the spin0 storage pool"
}
