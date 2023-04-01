output "batch_compute_env_id" {
  value = aws_batch_compute_environment.batch_environment.id
}

output "batch_job_def_id" {
  value = aws_batch_job_definition.job.id
}

output "batch_job_queue_id" {
  value = aws_batch_job_queue.job_queue.id
}

output "iam_ec2_inst_profile_id" {
  value = aws_iam_instance_profile.ec2_profile.id
}

output "iam_policy_s3_id" {
  value = aws_iam_policy.s3_policy.id
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
