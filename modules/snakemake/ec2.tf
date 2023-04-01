# IAM Role for underlying EC2 instances
resource "aws_iam_role" "ec2_role" {
  name = "${var.name}_ec2_role"
  assume_role_policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [{
      "Action" = "sts:AssumeRole",
      "Principal" = {
        "Service" = "ec2.amazonaws.com"
      },
      "Effect" = "Allow",
      "Sid"    = ""
    }]
  })
  tags = {
    created-by = "terraform"
  }
}

# Assign the EC2 role to the EC2 profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.name}_ec2_profile"
  role = aws_iam_role.ec2_role.name
}

# Attach the EC2 container service policy to the EC2 role
resource "aws_iam_role_policy_attachment" "ec2_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
