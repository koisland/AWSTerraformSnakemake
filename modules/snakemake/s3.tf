# tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "output" {
  bucket = "${var.name}-output"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "output_encryption" {
  bucket = aws_s3_bucket.output.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = "arn"
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "output_versioning" {
  bucket = aws_s3_bucket.output.id
  versioning_configuration {
    status = "Enabled"
  }
}

# tflint-ignore: terraform_required_providers
resource "aws_s3_bucket_public_access_block" "output_access" {
  bucket                  = aws_s3_bucket.output.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
