resource "incus_network" "reverse_proxy" {
  name = "reverse_proxy"
  type = "ovn"
  config = {
    "ipv4.address" = "10.0.5.1/24"
    "ipv4.nat"     = false
    "network"      = "${incus_network.incusbr0.name}"
    "security.acls" = join(",",
      [
        var.internal_dns_acl,
        var.external_dns_acl,
        var.http_acl,
        var.http_inbound_acl,
        var.ssh_mgmt_acl,
        var.wazuh_security_acl,
        var.tailscale_inbound_acl
    ])
  }
}

resource "incus_network_peer" "reverse_proxy_code" {
  name           = "reverse-proxy-code"
  description    = "Allow peering between reverse-proxy and code networks"
  network        = incus_network.reverse_proxy.name
  project        = "default"
  target_network = incus_network.code.name
  target_project = "default"
}

resource "incus_network_peer" "reverse_proxy_dns" {
  name           = "reverse-proxy-dns"
  description    = "Allow peering between reverse-proxy and dns networks"
  network        = incus_network.reverse_proxy.name
  project        = "default"
  target_network = incus_network.dns.name
  target_project = "default"
}

resource "incus_network_peer" "reverse_proxy_trusted" {
  name           = "reverse-proxy-trusted"
  description    = "Allow peering between reverse-proxy and trusted networks"
  network        = incus_network.reverse_proxy.name
  project        = "default"
  target_network = incus_network.trusted.name
  target_project = "default"
}

resource "incus_network_peer" "reverse_proxy_untrusted" {
  name           = "reverse-proxy-untrusted"
  description    = "Allow peering between reverse-proxy and untrusted networks"
  network        = incus_network.reverse_proxy.name
  project        = "default"
  target_network = incus_network.untrusted.name
  target_project = "default"
}

resource "incus_network_peer" "reverse_proxy_management" {
  name           = "reverse-proxy-management"
  description    = "Allow peering between reverse-proxy and management networks"
  network        = incus_network.reverse_proxy.name
  project        = "default"
  target_network = incus_network.management.name
  target_project = "default"
}

resource "incus_network_peer" "reverse_proxy_monitoring" {
  name           = "reverse-proxy-monitoring"
  description    = "Allow peering between reverse-proxy and monitoring networks"
  network        = incus_network.reverse_proxy.name
  project        = "default"
  target_network = incus_network.monitoring.name
  target_project = "default"
}
