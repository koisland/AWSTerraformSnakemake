
# Security Group for batch processing
resource "aws_security_group" "batch_standard" {
  name        = "${var.name}-batch-standard"
  description = "AWS Batch Security Group for batch jobs."
  vpc_id      = data.aws_vpc.default.id

  tags = {
    created-by = "terraform"
  }
}

resource "aws_batch_compute_environment" "standard" {
  compute_environment_name = "${var.name}-standard"
  compute_resources {
    instance_role = aws_iam_instance_profile.ec2_profile.arn
    instance_type = [
      "optimal"
    ]
    max_vcpus = var.batch_compute_env_max_vcpus
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
  name     = "${var.name}-main-queue"
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
  name = "${var.name}-standard"
  type = "container"
  # Parameters are added by lambda function.
  parameters = {
    "config" = ""
  }
  container_properties = jsonencode({
    "image"      = var.batch_smk_image,
    "jobRoleArn" = aws_iam_role.ecs_job_role.arn,
    "vcpus"      = var.batch_job_def_specs["vcpus"],
    "memory"     = var.batch_job_def_specs["memory"],
    "command"    = var.batch_job_def_specs["command"],
  })
  tags = {
    created-by = "terraform"
  }
}
