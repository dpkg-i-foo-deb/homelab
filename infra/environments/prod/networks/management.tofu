resource "incus_network_acl" "management_ssh_outbound" {
  name = "management-ssh-outbound"

  egress = [
    {
      action = "allow"
      destination = join(",",
        [
          incus_network.code.config["ipv4.address"],
          incus_network.dns.config["ipv4.address"],
          incus_network.privileged.config["ipv4.address"],
          incus_network.reverse_proxy.config["ipv4.address"],
          incus_network.storage.config["ipv4.address"],
          incus_network.torrenting.config["ipv4.address"],
          incus_network.trusted.config["ipv4.address"],
          incus_network.untrusted.config["ipv4.address"],
          incus_network.monitoring.config["ipv4.address"],
          incus_network.work.config["ipv4.address"],
          var.allowed_ssh_mgmt_subnets
        ]
      )
      destination_port = "22"
      protocol         = "tcp"
      description      = "Allow outbound SSH to homelab subnets"
      state            = "logged"
    },
  ]
}

resource "incus_network_acl" "management_rdp_outbound" {
  name = "management-rdp-outbound"

  egress = [
    {
      action = "allow"
      destination = join(",",
        [

          incus_network.work.config["ipv4.address"],

        ]
      )
      destination_port = "3389"
      protocol         = "tcp"
      description      = "Allow outbound RDP (TCP)"
      state            = "enabled"
    },
    {
      action = "allow"
      destination = join(",",
        [

          incus_network.work.config["ipv4.address"],
        ]
      )
      destination_port = "3389"
      protocol         = "udp"
      description      = "Allow outbound RDP (UDP)"
      state            = "enabled"
    },
  ]
}

resource "incus_network" "management" {
  name = "management"
  type = "ovn"
  config = {
    "ipv4.address" = "10.0.1.1/24"
    "ipv4.nat"     = false
    "network"      = "${incus_network.incusbr0.name}"
    "security.acls" = join(",",
      [
        var.internal_dns_acl,
        var.http_acl,
        var.ssh_mgmt_acl,
        var.ssh_outbound_acl,
        incus_network_acl.management_ssh_outbound.name,
        incus_network_acl.management_rdp_outbound.name,
        var.wazuh_security_acl,
        var.incus_api_outbound_acl,
        var.tailscale_inbound_acl,
    ])
  }
}

resource "incus_network_peer" "management_monitoring" {
  name           = "management-monitoring"
  description    = "Allow peering between management and monitoring networks"
  network        = incus_network.management.name
  project        = "default"
  target_network = incus_network.monitoring.name
  target_project = "default"
}

resource "incus_network_peer" "management_dns" {
  name           = "management-dns"
  description    = "Allow peering between management and dns networks"
  network        = incus_network.management.name
  project        = "default"
  target_network = incus_network.dns.name
  target_project = "default"
}

resource "incus_network_peer" "mangagement_privileged" {
  name           = "management-privileged"
  description    = "Allow peering between management and privileged networks"
  network        = incus_network.management.name
  project        = "default"
  target_network = incus_network.privileged.name
  target_project = "default"
}

resource "incus_network_peer" "management_storage" {
  name           = "management-storage"
  description    = "Allow peering between management and storage networks"
  network        = incus_network.management.name
  project        = "default"
  target_network = incus_network.storage.name
  target_project = "default"
}

resource "incus_network_peer" "management_torrenting" {
  name           = "management-torrenting"
  description    = "Allow peering between management and torrenting netowrks"
  network        = incus_network.management.name
  project        = "default"
  target_network = incus_network.torrenting.name
  target_project = "default"
}

resource "incus_network_peer" "management_trusted" {
  name           = "management-trusted"
  description    = "Allow peering between management and trusted networks"
  network        = incus_network.management.name
  project        = "default"
  target_network = incus_network.trusted.name
  target_project = "default"
}

