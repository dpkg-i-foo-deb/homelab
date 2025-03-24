resource "incus_network" "code" {
  name = "code"
  type = "ovn"
  config = {
    "ipv4.address" = "10.0.7.1/24"
    "ipv4.nat"     = false
    "network"      = "${incus_network.incusbr0.name}"
  }
}
