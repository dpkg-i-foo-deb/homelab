resource "incus_network" "storage" {
  name = "storage"
  type = "ovn"
  config = {
    "ipv4.address" = "10.0.3.1/24"
    "ipv4.nat"     = false
    "network"      = "${incus_network.incusbr0.name}"

  }
}
