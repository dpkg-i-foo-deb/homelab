output "vc_cluster" {
  value       = incus_project.vc_cluster.name
  description = "VC Cluster machines"
}

output "default" {
  value       = incus_project.default.name
  description = "Default project"
}
