module "s3" {
  source = "git::https://github.com/tabletcorry/tf-aws-takahe.git//modules/shared_s3_cloudfront"
  name   = "mastodon"
  primary_domain_name = "sharpletters.net"
  domain_prefix_parts = ["production", "cdn", "mastodon"]
}

resource "aws_s3_bucket" "pgbackrest" {
  bucket_prefix = "mstdn-backup"
}


resource "aws_s3_bucket_acl" "pgbackrest" {
  bucket = aws_s3_bucket.pgbackrest.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "pgbackrest" {
  bucket = aws_s3_bucket.pgbackrest.id

  block_public_acls   = true
  block_public_policy = true
}