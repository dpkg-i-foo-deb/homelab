variable "virt_main_pool" {
  type        = string
  description = "The name of the main storage pool"
}

variable "trusted_net" {
  type = object({
    name   = string
    type   = string
    config = map(string)
  })
  description = "Trusted network object"
}