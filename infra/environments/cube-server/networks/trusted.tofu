resource "incus_network" "trusted" {
  name = "trusted"
  type = "bridge"
  config = {
    "ipv4.address"    = "10.0.0.1/24"
    "ipv4.nat"        = false
    "dns.nameservers" = "10.0.2.2"
  }
}
