resource "incus_network" "torrent" {
  name = "torrent"
  type = "bridge"
  config = {
    "ipv4.address"    = "10.0.4.1/24"
    "ipv4.nat"        = false
    "dns.nameservers" = "1.1.1.1, 1.0.0.1, 8.8.8.8, 8.8.4.4"
  }
}
