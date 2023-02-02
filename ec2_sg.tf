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