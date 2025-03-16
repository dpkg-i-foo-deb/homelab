resource "incus_network" "trusted" {
  name = "trusted"
  config = {
    "ipv4.address" = "10.0.0.1/24"
    "ipv4.nat"     = true
    "bridge.mtu"   = 9000
    "dns.search"   = "10.0.2.2, 10.0.2.3"
  }
}

resource "incus_network" "dns" {
  name = "dns"
  config = {
    "ipv4.address" = "10.0.2.1/24"
    "ipv4.nat"     = true
    "bridge.mtu"   = 9000
  }
}

resource "incus_network" "storage" {
  name = "storage"
  config = {
    "ipv4.address" = "10.0.3.1/24"
    "ipv4.nat"     = true
    "bridge.mtu"   = 9000
    "dns.search"   = "10.0.2.2, 10.0.2.3"
  }
}

resource "incus_network" "privileged" {
  name = "privileged"
  config = {
    "ipv4.address" = "10.0.4.1/24"
    "ipv4.nat"     = true
    "bridge.mtu"   = 9000
    "dns.search"   = "10.0.2.2, 10.0.2.3"
  }
}

resource "incus_network" "reverse_proxy" {
  name = "reverse_proxy"
  config = {
    "ipv4.address" = "10.0.5.1/24"
    "ipv4.nat"     = true
    "bridge.mtu"   = 9000
    "dns.search"   = "10.0.2.2, 10.0.2.3"
  }
}

resource "incus_network" "torrenting" {
  name = "torrenting"
  config = {
    "ipv4.address" = "10.0.6.1/24"
    "ipv4.nat"     = true
    "bridge.mtu"   = 9000
    "dns.search"   = "10.0.2.2, 10.0.2.3"
  }
}

resource "incus_network" "code" {
  name = "code"
  config = {
    "ipv4.address" = "10.0.7.1/24"
    "ipv4.nat"     = true
    "bridge.mtu"   = 9000
    "dns.search"   = "10.0.2.2, 10.0.2.3"
  }
}

resource "incus_network" "untrusted" {
  name = "untrusted"
  config = {
    "ipv4.address" = "10.0.8.1/24"
    "ipv4.nat"     = true
    "bridge.mtu"   = 9000
    "dns.search"   = "10.0.2.2, 10.0.2.3"
  }
}
