# Storage pools available

variable "virt_main_pool" {
  type        = string
  description = "The name of the main storage pool"
}

variable "virt_high_io_pool" {
  type        = string
  description = "The name of the high I/O storage pool"
}

variable "virt_spin0_pool" {
  type        = string
  description = "The name of the spin0 storage pool"
}
