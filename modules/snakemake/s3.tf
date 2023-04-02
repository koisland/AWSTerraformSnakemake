# tfsec:ignore:aws-s3-enable-bucket-logging
module "s3_smk_output" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = ">= 3.8.2"

  bucket                  = "${var.name}-output"
  acl                     = "private"
  restrict_public_buckets = true
  ignore_public_acls      = true
  block_public_policy     = true
  block_public_acls       = true

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = "arn"
        sse_algorithm     = "aws:kms"
      }
    }
  }

  versioning = {
    enabled = true
  }
}

# tfsec:ignore:aws-s3-enable-bucket-logging
module "s3_smk_input" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = ">= 3.8.2"

  bucket                  = "${var.name}-input"
  acl                     = "private"
  restrict_public_buckets = true
  ignore_public_acls      = true
  block_public_policy     = true
  block_public_acls       = true

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = "arn"
        sse_algorithm     = "aws:kms"
      }
    }
  }

  versioning = {
    enabled = true
  }
}

module "s3_notification" {
  source  = "terraform-aws-modules/s3-bucket/aws//modules/notification"
  version = ">= 3.8.2"

  bucket = module.s3_smk_input.s3_bucket_id

  eventbridge = true

  lambda_notifications = {
    lambda1 = {
      function_arn  = module.lambda_function.lambda_function_arn
      function_name = module.lambda_function.lambda_function_name
      events        = ["s3:ObjectCreated:*"]
      filter_prefix = "data/"
      filter_suffix = ".json"
    }
  }
}
