locals {
  module_tags = {
    module          = "tf-aws-mastodon"
    module_var_name = var.name
  }
  tags = merge(local.module_tags, var.tags)

  full_domain_name = "${var.host_name}.${var.primary_domain_name}"

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