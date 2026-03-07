module "projects" {
  source = "./projects"

  providers = {
    incus = incus
  }

}