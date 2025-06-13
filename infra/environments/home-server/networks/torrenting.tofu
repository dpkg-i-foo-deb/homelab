resource "incus_network" "torrenting" {
  name = "torrenting"
  type = "bridge"
  config = {
    "ipv4.address"    = "10.0.6.1/24"
    "ipv4.nat"        = true
    "dns.nameservers" = "10.0.2.2,10.0.2.3"
  }
}
