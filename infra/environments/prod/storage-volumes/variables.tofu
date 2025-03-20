# Storage pools available

variable "virt_main_pool" {
  type = string
  description = "The name of the main storage pool"
}

variable "virt_high_io_pool" {
  type = string
  description = "The name of the high I/O storage pool"
}

variable "virt_spin_usb_pool" {
  type = string
  description = "The name of the HDD USB storage pool"
}
