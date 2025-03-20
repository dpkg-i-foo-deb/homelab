resource "incus_network" "code" {
  name = "code"
  config = {
    "ipv4.address" = "10.0.7.1/24"
    "ipv4.nat"     = true
    "bridge.mtu"   = 9000
    "dns.search"   = "10.0.2.2, 10.0.2.3"
  }
}