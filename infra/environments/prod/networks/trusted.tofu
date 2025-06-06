resource "incus_network" "trusted" {
  name = "trusted"
  type = "ovn"
  config = {
    "ipv4.address" = "10.0.0.1/24"
    "ipv4.nat"     = false
    "network"      = "${incus_network.incusbr0.name}"
    "security.acls" = join(",",
      [
        var.internal_dns_acl,
        var.http_acl,
        var.ssh_mgmt_acl,
        var.wazuh_security_acl,
        var.tailscale_inbound_acl
    ])
  }
}

resource "incus_network_peer" "trusted_reverse_proxy" {
  name           = "trusted-reverse-proxy"
  description    = "Allow peering between trusted and reverse-proxy networks"
  network        = incus_network.trusted.name
  project        = "default"
  target_network = incus_network.reverse_proxy.name
  target_project = "default"
}

resource "incus_network_peer" "trusted_management" {
  name           = "trusted-management"
  description    = "Allow peering between trusted and management networks"
  network        = incus_network.trusted.name
  project        = "default"
  target_network = incus_network.management.name
  target_project = "default"
}
