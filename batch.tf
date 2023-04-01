
# Security Group for batch processing
resource "aws_security_group" "batch_security_group" {
  name        = "batch_security_group"
  description = "AWS Batch Security Group for batch jobs"
  vpc_id      = data.aws_vpc.default.id

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    created-by = "terraform"
  }
}

resource "aws_batch_compute_environment" "batch_environment" {
  compute_environment_name = "batch-environment"
  compute_resources {
    instance_role = aws_iam_instance_profile.ec2_profile.arn
    instance_type = [
      "optimal"
    ]
    max_vcpus = 2
    min_vcpus = 0
    security_group_ids = [
      aws_security_group.batch_security_group.id,
    ]
    subnets = data.aws_subnets.default.ids
    type    = "EC2"
  }
  service_role = aws_iam_role.batch_role.arn
  type         = "MANAGED"
  tags = {
    created-by = "terraform"
  }
}

resource "aws_batch_job_queue" "job_queue" {
  name     = "job_queue"
  state    = "ENABLED"
  priority = 1
  compute_environments = [
    aws_batch_compute_environment.batch_environment.arn
  ]
  depends_on = [aws_batch_compute_environment.batch_environment]
  tags = {
    created-by = "terraform"
  }
}

resource "aws_batch_job_definition" "job" {
  name                 = "job"
  type                 = "container"
  parameters           = {}
  container_properties = <<CONTAINER_PROPERTIES
    {
    "image": "${var.image}",
    "jobRoleArn": "${aws_iam_role.ecs_job_role.arn}",
    "vcpus": 2,
    "memory": 1024,
    }
    CONTAINER_PROPERTIES
  tags = {
    created-by = "terraform"
  }
}