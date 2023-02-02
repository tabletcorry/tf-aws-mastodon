resource "random_password" "rds_root" {
  length  = 32
  special = false
}

/*resource "aws_db_instance" "self" {
  allocated_storage = 20

  identifier = "${local.module_tags.module}-${var.name}"

  engine               = "postgres"
  engine_version       = "14.5"
  instance_class       = "db.t4g.micro"
  username             = "mastodon"
  password             = random_password.rds_root.result
  parameter_group_name = "default.postgres14"
  skip_final_snapshot  = true

  multi_az = false

  allow_major_version_upgrade = false
  auto_minor_version_upgrade  = true

  apply_immediately = true

  availability_zone = "us-west-2a"

  backup_retention_period = 0
  backup_window           = "09:46-10:16"

  copy_tags_to_snapshot = true

  db_subnet_group_name = module.vpc.database_subnet_group_name
  network_type         = "DUAL"

  storage_type = "gp2"

  vpc_security_group_ids = [aws_security_group.rds.id]
}*/