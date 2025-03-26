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
        var.http_acl,
        var.http_inbound_acl,
        var.ssh_mgmt_acl,
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

# DELETE LATER
resource "incus_network_peer" "reverse_proxy_torrenting" {
  name           = "reverse-proxy-torrenting"
  description    = "Allow peering between reverse-proxy and torrenting networks"
  network        = incus_network.reverse_proxy.name
  project        = "default"
  target_network = incus_network.torrenting.name
  target_project = "default"
}
