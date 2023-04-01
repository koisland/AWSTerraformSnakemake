variable "image" {
  description = "Base docker image."
  type        = string
  default     = "snakemake/snakemake:latest"
}

variable "region" {
  default = "us-west-1"
}
