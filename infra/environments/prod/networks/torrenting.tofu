resource "incus_network" "torrenting" {
  name = "torrenting"
  type = "ovn"
  config = {
    "ipv4.address" = "10.0.6.1/24"
    "ipv4.nat"     = false
    "network"      = "${incus_network.incusbr0.name}"
    "security.acls" = join(",",
      [
        var.internal_dns_acl,
        var.http_acl,
        var.ssh_mgmt_acl
    ])
  }
}

resource "incus_network_peer" "torrenting_dns" {
  name           = "torrenting-dns"
  description    = "Allow peering between torrenting and dns networks"
  network        = incus_network.torrenting.name
  project        = "default"
  target_network = incus_network.dns.name
  target_project = "default"
}