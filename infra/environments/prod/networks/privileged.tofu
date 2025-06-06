resource "incus_network" "privileged" {
  name = "privileged"
  type = "bridge"
  config = {
    "ipv4.address" = "10.0.4.1/24"
    "ipv4.nat"     = true
  }
}