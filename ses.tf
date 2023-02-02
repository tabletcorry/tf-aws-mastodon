module "ses" {
  source = "git::https://github.com/tabletcorry/tf-aws-takahe.git//modules/shared_ses"
  name = var.name
  primary_domain_name = var.primary_domain_name
  takahe_domain_name = "mastodon.sharpletters.net"
  tags = local.tags
}