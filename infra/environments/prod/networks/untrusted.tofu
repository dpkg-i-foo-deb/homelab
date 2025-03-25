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
        var.ssh_mgmt_acl
    ])
  }
}
