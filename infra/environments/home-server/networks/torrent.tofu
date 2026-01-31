resource "incus_network" "torrent" {
  name = "torrent"
  type = "bridge"
  config = {
    "ipv4.address"    = "10.0.4.1/24"
    "ipv4.nat"        = false
    "dns.nameservers" = "10.0.2.3"
  }
}
