output "music" {
  value       = incus_storage_volume.music.name
  description = "The name of the shared music volume"
}

output "downloads" {
  value       = incus_storage_volume.downloads.name
  description = "The name of the shared downloads volume"
}

output "photos" {
  value       = incus_storage_volume.photos.name
  description = "The name of the shared photos volume"
}
