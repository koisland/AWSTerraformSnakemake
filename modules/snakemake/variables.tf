variable "batch_smk_image" {
  description = "Base Snakemake docker image."
  type        = string
  default     = ""
}

variable "batch_compute_env_max_vcpus" {
  description = "Batch compute environment max VCPUs."
  type        = number
  default     = 2
}

variable "batch_job_def_specs" {
  description = "Batch job definition specs."
  type        = any

  default = {
    "vcpus"   = 2,
    "memory"  = 1024
    "command" = ["snakemake", "-h"]
  }
}

variable "name" {
  description = "Name of pipeline"
  type        = string
  default     = ""
}
