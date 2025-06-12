resource "incus_network" "vcsoft" {
  name = "vcsoft"
  type = "bridge"
  config = {
    "ipv4.address"    = "10.0.3.1/24"
    "ipv4.nat"        = true
    "dns.nameservers" = "10.0.2.2,10.0.2.3"
  }
}
