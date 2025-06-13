resource "incus_network" "vcsoft" {
  name = "vcsoft"
  type = "bridge"
  config = {
    "ipv4.address"     = "10.0.3.1/24"
    "ipv4.nat"         = true
    "dns.nameservers"  = "10.0.2.2,10.0.2.3"
    "ipv4.dhcp.routes" = "0.0.0.0/0,10.0.3.1,10.1.0.0/24,10.0.3.5,10.2.0.0/24,10.0.3.5"
  }
}
