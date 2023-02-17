resource "aws_security_group" "ec2" {
  name   = "${local.module_tags.module}-${var.name}-ec2"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "ec2_egress" {
  security_group_id = aws_security_group.ec2.id
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}

resource "aws_security_group_rule" "ec2_ingress_https" {
  security_group_id        = aws_security_group.ec2.id
  type                     = "ingress"
  to_port                  = 443
  protocol                 = "tcp"
  from_port                = 443
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}

resource "aws_security_group_rule" "ec2_ingress_http" {
  security_group_id        = aws_security_group.ec2.id
  type                     = "ingress"
  to_port                  = 80
  protocol                 = "tcp"
  from_port                = 80
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}

resource "aws_security_group_rule" "ec2_ingress_icmp" {
  security_group_id        = aws_security_group.ec2.id
  type                     = "ingress"
  to_port                  = -1
  protocol                 = "icmp"
  from_port                = -1
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ec2_ingress_icmpv6" {
  security_group_id        = aws_security_group.ec2.id
  type                     = "ingress"
  to_port                  = -1
  protocol                 = "icmpv6"
  from_port                = -1
  ipv6_cidr_blocks = ["::/0"]
}

resource "aws_security_group" "postgres" {
  name   = "${local.module_tags.module}-${var.name}-postgres"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "postgres_egress" {
  security_group_id = aws_security_group.postgres.id
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}

resource "aws_security_group_rule" "postgres_ingress_ec2" {
  security_group_id        = aws_security_group.postgres.id
  type                     = "ingress"
  to_port                  = 5432
  protocol                 = "tcp"
  from_port                = 5432
  source_security_group_id = aws_security_group.ec2.id
}

resource "aws_security_group_rule" "postgres_ingress_ec2_icmp" {
  security_group_id        = aws_security_group.postgres.id
  type                     = "ingress"
  to_port                  = -1
  protocol                 = "icmp"
  from_port                = -1
  source_security_group_id = aws_security_group.ec2.id
}

resource "aws_security_group_rule" "postgres_ingress_ec2_icmpv6" {
  security_group_id        = aws_security_group.postgres.id
  type                     = "ingress"
  to_port                  = -1
  protocol                 = "icmpv6"
  from_port                = -1
  source_security_group_id = aws_security_group.ec2.id
}

