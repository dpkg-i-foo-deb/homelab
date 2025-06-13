module "acls" {
  source = "./acls"

  mgmt_subnets        = join(",", [var.home_subnet, "10.0.1.0/24"])
  allowed_ssh_subnets = join(",", data.github_ip_ranges.ranges.git)
  security_ip         = var.security_ip

  providers = {
    incus = incus
  }
}