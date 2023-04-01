terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "koisland"

    workspaces {
      name = "aws_terraform_smk_pipeline"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

module "snakemake" {
  source = "./modules/snakemake"
  name = "snakemake"
  image = "snakemake/snakemake:latest"
}
