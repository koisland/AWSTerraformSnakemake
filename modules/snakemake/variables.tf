variable "image" {
  description = "Base Snakemake docker image."
  type        = string
  default     = ""
}

variable "batch_max_vcpus" {
  description = "Batch max VCPUs."
  type        = number
  default = 2
}

variable "name" {
  default = ""
}
