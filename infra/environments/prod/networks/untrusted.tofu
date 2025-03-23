resource "incus_network" "untrusted" {
  name = "untrusted"
  config = {
    "ipv4.address" = "10.0.8.1/24"
    "ipv4.nat"     = true
    "bridge.mtu"   = 9000
    "dns.search"   = "10.0.2.2, 10.0.2.3"
  }
}
