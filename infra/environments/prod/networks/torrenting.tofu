resource "incus_network" "torrenting" {
  name = "torrenting"
  type = "ovn"
  config = {
    # "ipv4.address" = "10.0.6.1/24"
    # "ipv4.nat"   = true
    "bridge.mtu" = 9000
    "dns.search" = "10.0.2.2, 10.0.2.3"
    "network"    = "incusbr0"
  }
}
