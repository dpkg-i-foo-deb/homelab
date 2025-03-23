resource "incus_network" "trusted" {
  name = "trusted"
  type = "ovn"
  config = {
    "ipv4.address" = "10.0.0.1/24"
    "ipv4.nat"     = false
    "dns.search"   = "10.0.2.2, 10.0.2.3"
    "network"      = "${incus_network.incusbr0.name}"
  }
}
