resource "incus_network" "reverse_proxy" {
  name = "reverse_proxy"
  type = "ovn"
  config = {
    "ipv4.address" = "10.0.5.1/24"
    "ipv4.nat"     = false
    "network"      = "${incus_network.incusbr0.name}"
    "security.acls" = join(",",
      [
        var.internal_dns_acl,
        var.http_acl,
        var.http_inbound_acl,
        var.ssh_mgmt_acl,
    ])
  }
}
