resource "incus_network" "privileged" {
  name = "privileged"
  type = "ovn"
  config = {
    "ipv4.address" = "10.0.4.1/24"
    "ipv4.nat"     = false
    "network"      = "${incus_network.incusbr0.name}"
  }
}
