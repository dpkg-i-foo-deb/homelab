output "music" {
  value       = incus_storage_volume.music.name
  description = "The name of the shared music volume"
}

output "downloads" {
  value       = incus_storage_volume.downloads.name
  description = "The name of the shared downloads volume"
}