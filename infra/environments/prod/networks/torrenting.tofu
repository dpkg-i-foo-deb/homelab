resource "incus_network" "torrenting" {
  name = "torrenting"
  type = "bridge"
  config = {
    "ipv4.address" = "10.0.6.1/24"
    "ipv4.nat"     = true
  }
}
