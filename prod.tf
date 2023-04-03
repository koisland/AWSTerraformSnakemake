provider "aws" {
  region = "us-west-1"
}

terraform {
  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }

  cloud {
    organization = "koisland"

    workspaces {
      name = "aws_terraform_smk_pipeline"
    }
  }
}

module "snakemake" {
  source = "./modules/snakemake"
  # Create resources with this name prefixing it.
  name = "snakemake-standard"
  # Image used to kick-off pipeline.
  # This could be a custom image that downloads the s3 file that triggers batch job.
  batch_smk_image = "snakemake/snakemake:latest"
  # Max vcpus for compute env.
  batch_compute_env_max_vcpus = 2
  # Job definition specs.
  batch_job_def_specs = {
    "vcpus"  = 2,
    "memory" = 1024
    # Pass config batch parameter.
    # Could for example pass s3 URI so snakemake script/commands download s3 files.
    # {"file": "s3://example-bucket/path/to/object"}
    # https://snakemake.readthedocs.io/en/stable/snakefiles/configuration.html
    "command" = ["snakemake", "--config", "Ref::config"]
  }
}
