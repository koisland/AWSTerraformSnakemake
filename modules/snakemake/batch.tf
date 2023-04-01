
# Security Group for batch processing
resource "aws_security_group" "batch_standard" {
  name        = "${var.name}_batch_standard"
  description = "AWS Batch Security Group for batch jobs."
  vpc_id      = data.aws_vpc.default.id

  tags = {
    created-by = "terraform"
  }
}

resource "aws_batch_compute_environment" "standard" {
  compute_environment_name = "${var.name}_standard"
  compute_resources {
    instance_role = aws_iam_instance_profile.ec2_profile.arn
    instance_type = [
      "optimal"
    ]
    max_vcpus = var.batch_max_vcpus
    min_vcpus = 0
    security_group_ids = [
      aws_security_group.batch_standard.id,
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

resource "aws_batch_job_queue" "main_queue" {
  name     = "${var.name}_main_queue"
  state    = "ENABLED"
  priority = 1
  compute_environments = [
    aws_batch_compute_environment.standard.arn
  ]
  depends_on = [aws_batch_compute_environment.standard]
  tags = {
    created-by = "terraform"
  }
}

resource "aws_batch_job_definition" "standard" {
  name       = "${var.name}_standard"
  type       = "container"
  parameters = {}
  container_properties = jsonencode({
    "image"      = var.image,
    "jobRoleArn" = aws_iam_role.ecs_job_role.arn,
  })
  tags = {
    created-by = "terraform"
  }
}
