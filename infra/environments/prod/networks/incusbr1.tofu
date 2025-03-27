resource "incus_network" "incusbr1" {
  name = "incusbr1"
  type = "bridge"
  config = {
    "ipv4.address" = "10.0.12.1/24"
    "ipv4.nat"     = true
  }
}
