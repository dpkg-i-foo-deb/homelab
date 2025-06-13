resource "incus_network" "reverse_proxy" {
  name = "reverse_proxy"
  type = "bridge"
  config = {
    "ipv4.address"    = "10.0.5.1/24"
    "ipv4.nat"        = true
    "dns.nameservers" = "10.0.2.2,10.0.2.3"
  }
}
