resource "incus_network" "privileged" {
  name = "privileged"
  type = "ovn"
  config = {
    "ipv4.address" = "10.0.4.1/24"
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