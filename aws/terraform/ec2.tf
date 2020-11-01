resource "aws_key_pair" "key_pair" {
  key_name   = "${var.env}-ssh-key"
  public_key = file("~/.ssh/aws/${var.env}-proxy.pub")
}

resource "aws_security_group" "ec2-security-group" {
    name = "${var.env}-ec2-security-group"
    description = "Allow SSH inbound traffic"
    vpc_id = aws_vpc.main-vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# 80番ポート許可のインバウンドルール
resource "aws_security_group_rule" "inbound_http" {
  security_group_id = aws_security_group.ec2-security-group.id
  type = "ingress"
  from_port  = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = aws_security_group.alb-security-group.id
}


resource "aws_instance" "reverse-proxy" {
    ami = var.cent-id
    instance_type = "m5.large"
    key_name = "${var.env}-ssh-key"
    vpc_security_group_ids = [
      aws_security_group.ec2-security-group.id
    ]
    subnet_id = aws_subnet.public-subnet01.id
    associate_public_ip_address = "true"
    root_block_device {
      volume_type = "gp2"
      volume_size = "10"
    }
    tags = {
        Name = "${var.env}-proxy01"
    }
}

resource "aws_eip" "proxy-eip" {
  instance = aws_instance.reverse-proxy.id
  vpc = true
  tags = {
        Name = "${var.env}-proxy-eip"
  }
}