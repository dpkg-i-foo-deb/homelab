resource "incus_network" "transit" {
  name = "transit"
  type = "bridge"
  config = {
    "ipv4.address"    = "10.0.6.1/24"
    "ipv4.nat"        = false
    "dns.nameservers" = "10.0.2.2"
  }
}
