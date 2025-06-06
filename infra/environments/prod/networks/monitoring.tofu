resource "incus_network" "monitoring" {
  name = "monitoring"
  type = "ovn"
  config = {
    "ipv4.address" = "10.0.9.1/24"
    "ipv4.nat"     = false
    "network"      = "${incus_network.incusbr0.name}"
    "security.acls" = join(",",
      [
        var.internal_dns_acl,
        var.http_acl,
        var.ssh_mgmt_acl,
        var.wazuh_security_acl,
        var.tailscale_inbound_acl,
    ])
  }
}

resource "incus_network_peer" "monitoring_dns" {
  name           = "monitoring-dns"
  description    = "Allow peering between monitoring and dns networks"
  network        = incus_network.monitoring.name
  project        = "default"
  target_network = incus_network.dns.name
  target_project = "default"
}

resource "incus_network_peer" "monitoring_management" {
  name           = "monitoring-management"
  description    = "Allow peering between monitoring and management networks"
  network        = incus_network.monitoring.name
  project        = "default"
  target_network = incus_network.management.name
  target_project = "default"
}
