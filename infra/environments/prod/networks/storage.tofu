resource "incus_network" "storage" {
  name = "storage"
  type = "ovn"
  config = {
    "ipv4.address" = "10.0.3.1/24"
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

resource "incus_network_peer" "storage_dns" {
  name           = "storage-dns"
  description    = "Allow peering between storage and dnsnetworks"
  network        = incus_network.storage.name
  project        = "default"
  target_network = incus_network.dns.name
  target_project = "default"
}
