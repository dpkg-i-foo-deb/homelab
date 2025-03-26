resource "incus_network" "code" {
  name = "code"
  type = "ovn"
  config = {
    "ipv4.address" = "10.0.7.1/24"
    "ipv4.nat"     = false
    "network"      = "${incus_network.incusbr0.name}"
    "security.acls" = join(",",
      [
        var.internal_dns_acl,
        var.http_acl,
        var.ssh_mgmt_acl,
        var.ssh_outbound_acl
    ])
  }
}

resource "incus_network_peer" "code_reverse_proxy" {
  name           = "code-reverse-proxy"
  description    = "Allow peering between code and reverse-proxy networks"
  network        = incus_network.code.name
  project        = "default"
  target_network = incus_network.reverse_proxy.name
  target_project = "default"
}
