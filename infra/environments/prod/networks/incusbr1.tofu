# Uplink whose dns search is set to a public dns resolver
# this will be used for my own dns servers
resource "incus_network" "incusbr1" {
  name = "incusbr1"
  type = "physical"
  config = {
    "parent"          = "enp7s0"
    "ipv4.gateway"    = "192.168.8.1/24"
    "ipv4.ovn.ranges" = "192.168.8.21-192.168.8.25",
    "ipv4.routes" = join(",", [
      "10.0.2.0/24",
    ])
    "bgp.peers.router.address" = "192.168.8.1"
    "bgp.peers.router.asn"     = 65537
    "dns.nameservers"          = "1.1.1.1, 1.0.0.1, 8.8.8.8, 8.8.4.4"
  }
}
