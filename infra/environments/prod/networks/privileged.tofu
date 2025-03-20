resource "incus_network" "privileged" {
  name = "privileged"
  config = {
    "ipv4.address" = "10.0.4.1/24"
    "ipv4.nat"     = true
    "bridge.mtu"   = 9000
    "dns.search"   = "10.0.2.2, 10.0.2.3"
  }
}