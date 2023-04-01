# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

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
  region = var.region
}

# Security Setup
# Retrieves the default vpc for this region
data "aws_vpc" "default" {
  default = true
}

# Retrieves the subnet ids in the default vpc
data "aws_subnets" "default" {}
