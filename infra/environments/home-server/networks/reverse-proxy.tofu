resource "incus_network" "reverse_proxy" {
  name = "reverse_proxy"
  type = "bridge"
  config = {
    "ipv4.address"    = "10.0.5.1/24"
    "ipv4.nat"        = false
    "dns.nameservers" = "10.0.2.2"
    "ipv4.dhcp.routes" = "0.0.0.0/0,10.0.5.1,10.0.253.0/24,10.0.5.5"
  }
}
