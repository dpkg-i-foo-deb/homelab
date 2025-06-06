resource "incus_network" "untrusted" {
  name = "untrusted"
  type = "bridge"
  config = {
    "ipv4.address" = "10.0.8.1/24"
    "ipv4.nat"     = true
  }
}
