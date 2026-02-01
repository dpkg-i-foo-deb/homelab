resource "incus_network_acl" "drop" {
  name        = "drop-acl"
  description = "Kill everything"

  ingress = [
    {
      action      = "drop"
      description = "Default Drop Ingress"
      state       = "enabled"
      log         = true
    }
  ]

  egress = [
    {
      action      = "drop"
      description = "Default Drop Egress"
      state       = "enabled"
      log         = true
    }
  ]
}
