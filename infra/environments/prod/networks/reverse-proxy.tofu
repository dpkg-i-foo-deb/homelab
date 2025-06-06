resource "incus_network" "reverse_proxy" {
  name = "reverse_proxy"
  type = "bridge"
  config = {
    "ipv4.address" = "10.0.5.1/24"
    "ipv4.nat"     = true
  }
}
