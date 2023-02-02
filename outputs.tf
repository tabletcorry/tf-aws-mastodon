output "db_pass" {
  value = random_password.rds_root.result
}

output "s3_access_key" {
  value = module.s3.s3_iam_user_key_id
}

output "s3_access_key_secret" {
  value = module.s3.s3_iam_user_key_secret
}

output "ses_smtp_url" {
  value = module.ses.ses_smtp_url
}

output "ses_username" {
  value = module.ses.iam_access_key_id
}

output "ses_password" {
  value = module.ses.iam_access_key_ses_smtp_password_v4
}