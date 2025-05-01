resource "incus_network" "work" {
  name = "work"
  type = "ovn"
  config = {
    "ipv4.address" = "10.0.10.1/24"
    "ipv4.nat"     = false
    "network"      = "${incus_network.incusbr0.name}"
    "security.acls" = join(",",
      [
        var.internal_dns_acl,
        var.http_acl,
        var.ssh_mgmt_acl,
        var.wazuh_security_acl,
        var.tailscale_inbound_acl,
    ])
  }
}

resource "incus_network_peer" "work_dns" {
  name           = "work-dns"
  description    = "Allow peering between work and dns networks"
  network        = incus_network.work.name
  project        = "default"
  target_network = incus_network.dns.name
  target_project = "default"
}