resource "incus_network" "monitoring" {
  name = "monitoring"
  type = "bridge"
  config = {
    "ipv4.address"    = "10.0.9.1/24"
    "ipv4.nat"        = true
    "dns.nameservers" = "10.0.2.2,10.0.2.3"
  }
}
