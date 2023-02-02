data "aws_route53_zone" "self" {
  name = var.primary_domain_name
}

data "aws_caller_identity" "self" {}

data "aws_region" "self" {}