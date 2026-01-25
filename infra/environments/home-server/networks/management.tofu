resource "incus_network" "management" {
  name = "management"
  type = "bridge"
  config = {
    "ipv4.address"    = "10.0.1.1/24"
    "ipv4.nat"        = false
    "dns.nameservers" = "10.0.2.2"
    "ipv4.dhcp.routes" = "0.0.0.0/0,10.0.1.1,10.0.254.0/24,10.0.1.20,10.0.253.0/24,10.0.1.20,10.0.252.0/24,10.0.1.20"
  }
}
