resource "aws_route53_record" "ec2_a" {
  name    = local.full_domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.self.zone_id

  records = [aws_eip.ec2.public_ip]
  ttl = 60
}

resource "aws_route53_record" "ec2_aaaa" {
  name    = local.full_domain_name
  type    = "AAAA"
  zone_id = data.aws_route53_zone.self.zone_id

  records = aws_instance.web.ipv6_addresses
  ttl = 60
}

resource "aws_route53_record" "acm_caa" {
  name    = local.full_domain_name
  type    = "CAA"
  ttl     = 3600
  records = ["0 issue \"letsencrypt.org\""]
  zone_id = data.aws_route53_zone.self.zone_id
}

/*resource "aws_route53_record" "postgres_a" {
  name    = "postgres.${local.full_domain_name}"
  type    = "A"
  zone_id = data.aws_route53_zone.self.zone_id

  records = [aws_eip.postgres.private_ip]
  ttl = 60
}*/

resource "aws_route53_record" "postgres_aaaa" {
  name    = "postgres.${local.full_domain_name}"
  type    = "AAAA"
  zone_id = data.aws_route53_zone.self.zone_id

  records = aws_instance.postgres.ipv6_addresses
  ttl = 60
}