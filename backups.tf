/*resource "aws_backup_vault" "ec2" {
  name        = "${local.module_tags.module}-${var.name}"
}

resource "aws_backup_plan" "example" {
  name = "${local.module_tags.module}-${var.name}-ec2"

  rule {
    rule_name         = "daily"
    target_vault_name = aws_backup_vault.ec2.name
    schedule          = "cron(0 12 * * ? *)"

    lifecycle {
      delete_after = 14
    }
  }

  advanced_backup_setting {
    backup_options = {
      WindowsVSS = "enabled"
    }
    resource_type = "EC2"
  }
}*/