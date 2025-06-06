resource "incus_network" "privileged" {
  name = "privileged"
  type = "bridge"
  config = {
    "ipv4.address"    = "10.0.4.1/24"
    "ipv4.nat"        = true
    "dns.nameservers" = "10.0.2.2,10.0.2.3"
  }
}
