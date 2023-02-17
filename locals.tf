locals {
  module_tags = {
    module          = "tf-aws-mastodon"
    module_var_name = var.name
  }
  tags = merge(local.module_tags, var.tags)

  full_domain_name = "${var.host_name}.${var.primary_domain_name}"

  postgres_bucket_interact = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject"
        ]
        Effect = "Allow"
        Resource = [
          aws_s3_bucket.pgbackrest.arn,
          "${aws_s3_bucket.pgbackrest.arn}/*"
        ]
      }
    ]
  }
  )

  ecs_task_bucket_read = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:Get*",
          "s3:Put*",
        ]
        Effect = "Allow"
        Resource = [
          module.s3.s3_arn,
          "${module.s3.s3_arn}/*",
        ]
      },
      {
        Action = [
          "kms:Decrypt"
        ]
        Effect = "Allow"
        Resource = [
          data.aws_kms_alias.ssm_session_manager.target_key_arn
        ]
      }
    ]
  })
}

data "aws_kms_alias" "ssm_session_manager" {
  name = "alias/ssm-session-manager"
}