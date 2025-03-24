resource "incus_network" "dns" {
  name = "dns"
  type = "ovn"
  config = {
    "ipv4.address" = "10.0.2.1/24"
    "ipv4.nat"     = false
    "network"      = "${incus_network.incusbr0.name}"
    "security.acls" = join(",",
      [
        var.external_dns_acl,
        var.internal_dns_acl,
        var.inbound_dns_acl,
        var.http_acl,
        var.ssh_mgmt_acl
    ])
  }
}
