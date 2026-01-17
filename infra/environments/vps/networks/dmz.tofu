resource "incus_network" "dmz" {
  name = "dmz"
  type = "bridge"
  config = {
    "ipv4.address" = "10.0.253.1/24"
    "ipv4.nat"     = true
    "ipv4.dhcp.routes" = "0.0.0.0/0,10.0.253.1,10.0.5.0/24,10.0.253.5"
  }
}
