resource "incus_network" "external" {
  name = "external"
  type = "ovn"
  config = {
    "ipv4.address" = "10.0.11.1/24"
    "ipv4.nat"     = false
    "network"      = "${incus_network.incusbr0.name}"
    "security.acls" = join(",",
      [
        var.internal_dns_acl,
        var.http_acl,
        var.ssh_mgmt_acl,
    ])
  }
}

resource "incus_network_peer" "external_dns" {
  name           = "external-dns"
  description    = "Allow peering between external and dns networks"
  network        = incus_network.external.name
  project        = "default"
  target_network = incus_network.dns.name
  target_project = "default"
}
