resource "incus_network" "privileged" {
  name = "privileged"
  type = "ovn"
  config = {
    "ipv4.address" = "10.0.4.1/24"
    "ipv4.nat"     = false
    "network"      = "${incus_network.incusbr0.name}"
  }
}

resource "incus_network_peer" "privileged_dns" {
  name           = "privileged_dns"
  description    = "Allow peering between privileged and dns networks"
  network        = incus_network.privileged.name
  project        = "default"
  target_network = incus_network.dns.name
  target_project = "default"
}