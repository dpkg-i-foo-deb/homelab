resource "incus_network" "work" {
  name = "work"
  type = "bridge"
  config = {
    "ipv4.address" = "10.0.10.1/24"
    "ipv4.nat"     = true
  }
}