# Main virtual machine uplink, it has dns nameservers set
# to my own dns which filters a lot of internet junk
resource "incus_network" "incusbr0" {
  name = "incusbr0"
  type = "physical"
  config = {
    "parent"          = "enp6s0"
    "ipv4.gateway"    = "192.168.8.1/24"
    "ipv4.ovn.ranges" = "192.168.8.5-192.168.8.20",
    "ipv4.routes" = join(",", [
      "10.0.0.0/24",
      "10.0.1.0/24",
      "10.0.3.0/24",
      "10.0.4.0/24",
      "10.0.6.0/24",
      "10.0.7.0/24",
      "10.0.9.0/24",
    ])
    "bgp.peers.router.address" = "192.168.8.1"
    "bgp.peers.router.asn"     = 65537
    "dns.nameservers"          = "10.0.2.2, 10.0.2.3"
  }
}
