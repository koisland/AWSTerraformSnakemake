resource "aws_s3_bucket" "output" {
  bucket = "${var.name}-output"
}

resource "aws_s3_bucket_acl" "output_acl" {
  bucket = aws_s3_bucket.output.id
  acl    = "private"
}
