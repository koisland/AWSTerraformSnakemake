provider "aws" {
  region = "us-west-1"
}

terraform {
  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
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
  name   = "snakemake"
  image  = "snakemake/snakemake:latest"
}
