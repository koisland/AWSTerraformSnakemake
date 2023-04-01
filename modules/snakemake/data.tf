# Security Setup
# Retrieves the default vpc for this region
data "aws_vpc" "default" {
  default = true
}

# Retrieves the subnet ids in the default vpc
data "aws_subnets" "default" {}
