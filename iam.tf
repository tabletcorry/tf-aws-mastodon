resource "aws_iam_instance_profile" "ec2" {
  name = "${local.module_tags.module}-${var.name}-ec2"
  role = aws_iam_role.ec2.name
}

resource "aws_iam_role" "ec2" {
  name = "${local.module_tags.module}-${var.name}-ec2"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "ec2_s3" {
  role = aws_iam_role.ec2.id

  policy = local.ecs_task_bucket_read
}

resource "aws_iam_role_policy_attachment" "ec2_ssm" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ec2.id
}