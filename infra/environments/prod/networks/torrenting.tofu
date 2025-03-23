resource "incus_network" "torrenting" {
  name = "torrenting"
  #type = "bridge"
  type = "ovn"
  config = {
    "ipv4.address" = "10.0.6.1/24"
    "ipv4.nat"     = false
    "dns.search"   = "10.0.2.2, 10.0.2.3"
    "network"      = "${incus_network.incusbr0.name}"
  }
}
