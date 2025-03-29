resource "incus_network" "untrusted" {
  name = "untrusted"
  type = "ovn"
  config = {
    "ipv4.address" = "10.0.8.1/24"
    "ipv4.nat"     = false
    "network"      = "${incus_network.incusbr0.name}"
    "security.acls" = join(",",
      [
        var.internal_dns_acl,
        var.http_acl,
        var.ssh_mgmt_acl,
        var.wazuh_security_acl
    ])
  }
}

resource "incus_network_peer" "untrusted_reverse_proxy" {
  name           = "untrusted-reverse-proxy"
  description    = "Allow peering between untrusted and reverse-proxy networks"
  network        = incus_network.untrusted.name
  project        = "default"
  target_network = incus_network.reverse_proxy.name
  target_project = "default"
}

resource "incus_network_peer" "untrusted_dns" {
  name           = "untrusted-dns"
  description    = "Allow peering between untrusted and dns networks"
  network        = incus_network.untrusted.name
  project        = "default"
  target_network = incus_network.dns.name
  target_project = "default"
}
