module "s3" {
  source = "git::https://github.com/tabletcorry/tf-aws-takahe.git//modules/shared_s3_cloudfront"
  name   = "mastodon"
  primary_domain_name = "sharpletters.net"
  domain_prefix_parts = ["production", "cdn", "mastodon"]
}