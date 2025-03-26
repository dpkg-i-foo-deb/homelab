resource "incus_network" "dns" {
  name = "dns"
  type = "ovn"
  config = {
    "ipv4.address" = "10.0.2.1/24"
    "ipv4.nat"     = false
    "network"      = "${incus_network.incusbr0.name}"
    "security.acls" = join(",",
      [
        var.external_dns_acl,
        var.internal_dns_acl,
        var.inbound_dns_acl,
        var.http_acl,
        var.ssh_mgmt_acl
    ])
  }
}

resource "incus_network_peer" "dns_code" {
  name           = "dns-code"
  description    = "Allow peering between dns and code networks"
  network        = incus_network.dns.name
  project        = "default"
  target_network = incus_network.code.name
  target_project = "default"
}

resource "incus_network_peer" "dns_reverse_proxy" {
  name           = "dns-reverse-proxy"
  description    = "Allow peering between reverse-proxy and dns networks"
  network        = incus_network.dns.name
  project        = "default"
  target_network = incus_network.reverse_proxy.name
  target_project = "default"
}
