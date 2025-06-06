resource "incus_network" "dns" {
  name = "dns"
  type = "ovn"
  config = {
    "ipv4.address" = "10.0.2.1/24"
    "ipv4.nat"     = false
    "network"      = "${incus_network.incusbr1.name}"
    "security.acls" = join(",",
      [
        var.external_dns_acl,
        var.internal_dns_acl,
        var.inbound_dns_acl,
        var.http_acl,
        var.ssh_mgmt_acl,
        var.wazuh_security_acl,
        var.tailscale_inbound_acl
    ])
  }
}

resource "incus_network_peer" "dns_privileged" {
  name           = "dns-privileged"
  description    = "Allow peering between dns and privileged networks"
  network        = incus_network.dns.name
  project        = "default"
  target_network = incus_network.privileged.name
  target_project = "default"
}


resource "incus_network_peer" "dns_storage" {
  name           = "dns-storage"
  description    = "Allow peering between dns and storage networks"
  network        = incus_network.dns.name
  project        = "default"
  target_network = incus_network.storage.name
  target_project = "default"
}

resource "incus_network_peer" "dns_trusted" {
  name           = "dns-trusted"
  description    = "Allow peering between dns and trusted networks"
  network        = incus_network.dns.name
  project        = "default"
  target_network = incus_network.trusted.name
  target_project = "default"
}

resource "incus_network_peer" "dns_management" {
  name           = "dns-management"
  description    = "Allow peering between dns and management networks"
  network        = incus_network.dns.name
  project        = "default"
  target_network = incus_network.management.name
  target_project = "default"
}

resource "incus_network_peer" "dns_monitoring" {
  name           = "dns-monitoring"
  description    = "Allow peering between dns and monitoring networks"
  network        = incus_network.dns.name
  project        = "default"
  target_network = incus_network.monitoring.name
  target_project = "default"
}
