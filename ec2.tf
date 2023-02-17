resource "aws_eip" "ec2" {
  instance = aws_instance.web.id
  vpc      = true

  tags = {
    Name = "Mastodon"
  }
}

resource "aws_eip" "postgres" {
  instance = aws_instance.postgres.id
  vpc      = true

  tags = {
    Name = "Mastodon-Postgres"
  }
}

resource "aws_instance" "postgres" {
  ami           = "ami-079f51a7bcca65b92"
  instance_type = "t4g.micro"

  disable_api_termination = true

  associate_public_ip_address = true

  availability_zone = "us-west-2a"

  iam_instance_profile = aws_iam_instance_profile.postgres.name

  ipv6_address_count = 1

  key_name = "mastodon"

  subnet_id = module.vpc.public_subnets[0]

  vpc_security_group_ids = [aws_security_group.postgres.id]

  root_block_device {
    delete_on_termination = false
    iops = 3000
    throughput = 125
    volume_size = 25
    volume_type = "gp3"
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  tags = {
    Name = "Mastodon-Postgres"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-079f51a7bcca65b92"
  instance_type = "t4g.small"

  disable_api_termination = true

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
    volume_size = 25
    volume_type = "gp3"
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  tags = {
    Name = "Mastodon-Web"
  }
}