module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = ">= 3.8.2"

  function_name = "${var.name}-lambda"
  description   = "Trigger for batch."
  handler       = "trigger.lambda_handler"
  runtime       = "python3.8"
  publish       = true

  source_path = "${path.module}/lambda_py"

  allowed_triggers = {
    AllowExecutionFromS3Bucket = {
      service    = "s3"
      source_arn = module.s3_smk_input.s3_bucket_arn
    }
  }

  # Add environment variables so lambda function can access names of batch resources.
  environment_variables = {
    job_queue = "${var.name}_main_queue",
    job_def   = "${var.name}_standard",
  }

  tags = {
    created-by = "terraform"
  }

  # Trace logs
  tracing_mode = "Active"
}
