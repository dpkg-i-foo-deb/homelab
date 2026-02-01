module "acls" {
  source = "./acls"

  allowed_ssh_subnets = join(",", data.github_ip_ranges.ranges.git)

  providers = {
    incus = incus
  }
}
