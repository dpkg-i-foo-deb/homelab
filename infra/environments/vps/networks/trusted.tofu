resource "incus_network" "trusted" {
  name = "trusted"
  type = "bridge"
  config = {
    "ipv4.address" = "10.0.254.1/24"
    "ipv4.nat"     = false
    "network"      = ""
  }
}
