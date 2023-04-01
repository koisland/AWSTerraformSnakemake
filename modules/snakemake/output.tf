# Batch
output "batch_compute_env_id" {
  value = aws_batch_compute_environment.standard.id
}

output "batch_job_def_id" {
  value = aws_batch_job_definition.standard.id
}

output "batch_job_queue_id" {
  value = aws_batch_job_queue.main_queue.id
}

# S3
output "s3_smk_output_bucket_id" {
  value = aws_s3_bucket.output.id
}

output "s3_smk_output_bucket_access_blk_id" {
  value = aws_s3_bucket_public_access_block.output_access.id
}

output "s3_smk_output_server_side_encryption_id" {
  value = aws_s3_bucket_server_side_encryption_configuration.output_encryption.id
}

output "s3_smk_output_bucket_versioning_id" {
  value = aws_s3_bucket_versioning.output_versioning.id
}

# IAM
output "iam_ec2_inst_profile_id" {
  value = aws_iam_instance_profile.ec2_profile.id
}

output "iam_policy_s3_id" {
  value = aws_iam_policy.read_write_s3.id
}

output "iam_role_batch_id" {
  value = aws_iam_role.batch_role.id
}

output "iam_role_ec2_id" {
  value = aws_iam_role.ec2_role.id
}

output "iam_role_ecs_job_id" {
  value = aws_iam_role.ecs_job_role.id
}

output "iam_role_policy_attach_ec2_id" {
  value = aws_iam_role_policy_attachment.ec2_policy_attachment.id
}

output "iam_role_policy_attach_s3_access_id" {
  value = aws_iam_role_policy_attachment.s3_access_policy_attachment.id
}

output "iam_role_policy_attach_batch_id" {
  value = aws_iam_role_policy_attachment.batch_policy_attachment.id
}