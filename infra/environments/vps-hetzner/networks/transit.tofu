resource "incus_network" "transit" {
  name = "transit"
  type = "bridge"
  config = {
    "ipv4.address" = "10.0.252.1/24"
    "ipv4.nat"     = true
    "ipv4.dhcp.routes" = "0.0.0.0/0,10.0.252.1"
  }
}
