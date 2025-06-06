resource "incus_network" "external" {
  name = "external"
  type = "bridge"
  config = {
    "ipv4.address" = "10.0.11.1/24"
    "ipv4.nat"     = true
  }
}
