resource "aws_instance" "self" {
  ami           = "ami-072d13a1cd84b5f6b"
  instance_type = "t4g.medium"

  associate_public_ip_address = true

  availability_zone = "us-west-2a"

  iam_instance_profile = aws_iam_instance_profile.ec2.name

  ipv6_address_count = 1

  key_name = "mastodon"

  subnet_id = module.vpc.public_subnets[0]

  vpc_security_group_ids = [aws_security_group.ec2.id]

  root_block_device {
    delete_on_termination = false
    iops = 3000
    throughput = 125
    volume_size = 50
    volume_type = "gp3"
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  tags = {
    Name = "Mastodon"
  }
}

resource "aws_eip" "ec2" {
  instance = aws_instance.self.id
  vpc      = true

  tags = {
    Name = "Mastodon"
  }
}

moved {
  from = aws_eip.lb
  to   = aws_eip.ec2
}