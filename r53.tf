resource "aws_route53_record" "ec2_a" {
  name    = local.full_domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.self.zone_id

  records = [aws_eip.ec2.public_ip]
  ttl = 3600
}

resource "aws_route53_record" "ec2_aaaa" {
  name    = local.full_domain_name
  type    = "AAAA"
  zone_id = data.aws_route53_zone.self.zone_id

  records = aws_instance.self.ipv6_addresses
  ttl = 3600
}

resource "aws_route53_record" "acm_caa" {
  name    = local.full_domain_name
  type    = "CAA"
  ttl     = 3600
  records = ["0 issue \"letsencrypt.org\""]
  zone_id = data.aws_route53_zone.self.zone_id
}