variable "incus_token" {
  type        = string
  description = "Incus API Token"
}

variable "main_storage_size" {
  type = string
  description = "Desired size for the main LVM storage pool"
}

variable "main_storage_source" {
  type = string
  description = "Source block device for the main LVM storage pool"
}


variable "high_io_storage_size" {
  type = string
  description = "Desired size of the High io LVM storage pool"
}

variable "high_io_storage_source" {
  type = string
  description = "Source block device for High io storage pool"
}

