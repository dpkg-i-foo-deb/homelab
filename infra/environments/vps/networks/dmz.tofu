resource "incus_network" "dmz" {
  name = "dmz"
  type = "bridge"
  config = {
    "ipv4.address" = "10.0.253.1/24"
    "ipv4.nat"     = true
  }
}
