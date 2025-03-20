resource "incus_network" "dns" {
  name = "dns"
  config = {
    "ipv4.address" = "10.0.2.1/24"
    "ipv4.nat"     = true
    "bridge.mtu"   = 9000
  }
}