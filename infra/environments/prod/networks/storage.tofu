resource "incus_network" "storage" {
  name = "storage"
  type = "bridge"
  config = {
    "ipv4.address" = "10.0.3.1/24"
    "ipv4.nat"     = true
  }
}
