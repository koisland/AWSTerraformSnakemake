# IAM Role for jobs
resource "aws_iam_role" "ecs_job_role" {
  name               = "ecs_job_role"
  assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement":
        [
        {
            "Action": "sts:AssumeRole",
            "Effect": "Allow",
            "Principal": {
                "Service": "ecs-tasks.amazonaws.com"
            }
        }
        ]
    }
    EOF
  tags = {
    created-by = "terraform"
  }
}

# S3 read/write policy
resource "aws_iam_policy" "s3_policy" {
  name   = "s3_policy"
  policy = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*",
                "s3:Put*"
            ],
            "Resource": [
                "${aws_s3_bucket.smk_output.arn}",
                "${aws_s3_bucket.smk_output.arn}/*"
            ]
        }
    ]
    }
    EOF
  tags = {
    created-by = "terraform"
  }
}

# Attach the policy to the job role
resource "aws_iam_role_policy_attachment" "s3_access_policy_attachment" {
  role       = aws_iam_role.ecs_job_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

# IAM Role for batch processing
resource "aws_iam_role" "batch_role" {
  name               = "batch_role"
  assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Effect": "Allow",
            "Principal": {
                "Service": "batch.amazonaws.com"
            }
        }
        ]
    }
    EOF
  tags = {
    created-by = "terraform"
  }
}

# Attach the Batch policy to the Batch role
resource "aws_iam_role_policy_attachment" "batch_policy_attachment" {
  role       = aws_iam_role.batch_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole"
}
