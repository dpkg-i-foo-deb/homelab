resource "incus_network" "code" {
  name = "code"
  type = "bridge"
  config = {
    "ipv4.address" = "10.0.7.1/24"
    "ipv4.nat"     = true
  }
}
