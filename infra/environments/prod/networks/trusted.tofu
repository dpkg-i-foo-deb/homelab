resource "incus_network" "trusted" {
  name = "trusted"
  type = "ovn"
  config = {
    "ipv4.address" = "10.0.0.1/24"
    "ipv4.nat"     = false
    "network"      = "${incus_network.incusbr0.name}"
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

resource "incus_network_peer" "trusted_dns" {
  name           = "trusted-dns"
  description    = "Allow peering between trusted and dns networks"
  network        = incus_network.trusted.name
  project        = "default"
  target_network = incus_network.dns.name
  target_project = "default"
}