resource "incus_network" "incusbr0" {
  name = "incusbr0"
  config = {
    "ipv4.address"    = "10.0.254.254/24"
    "ipv4.nat"        = true
    "bridge.mtu"      = 9000
    "ipv4.ovn.ranges" = "10.0.0.0-10.0.254.253"
  }
}
