module "acls" {
  source = "./acls"

  mgmt_subnets        = join(",", [var.home_subnet, "10.0.1.0/24"])
  allowed_ssh_subnets = join(",", data.github_ip_ranges.ranges.git)
  allowed_dns_subnets = join(",", data.cloudflare_ip_ranges.ranges.ipv4_cidr_blocks)
  security_ip         = var.security_ip
  incus_addresses     = join(",", var.hypervisor_addresses)

  providers = {
    incus = incus
  }
}