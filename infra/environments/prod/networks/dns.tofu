resource "incus_network" "dns" {
  name = "dns"
  type = "bridge"
  config = {
    "ipv4.address"    = "10.0.2.1/24"
    "ipv4.nat"        = true
    "dns.nameservers" = "1.1.1.1, 1.0.0.1, 8.8.8.8, 8.8.4.4"
  }
}
