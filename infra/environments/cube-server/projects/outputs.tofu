output "vc_cluster" {
  value       = incus_project.vcsoft.name
  description = "VCSOFT Machines"
}

output "external"{
  value       = incus_project.external.name
  description = "External project"
}

output "default" {
  value       = incus_project.default.name
  description = "Default project"
}
