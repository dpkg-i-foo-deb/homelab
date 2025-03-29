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


resource "incus_network_peer" "privileged_dns" {
  name           = "privileged-dns"
  description    = "Allow peering between privileged and dns networks"
  network        = incus_network.privileged.name
  project        = "default"
  target_network = incus_network.dns.name
  target_project = "default"
}

resource "incus_network_peer" "privileged_management" {
  name           = "privileged-management"
  description    = "Allow peering between privileged and management networks"
  network        = incus_network.privileged.name
  project        = "default"
  target_network = incus_network.management.name
  target_project = "default"
}
