resource "aws_key_pair" "key_pair" {
  key_name   = "${var.env}-ssh-key"
  public_key = file("~/.ssh/aws/${var.env}-proxy.pub")
}

resource "aws_instance" "reverse-proxy" {
    ami = var.cent-id
    instance_type = "t2.micro"
    key_name = "${var.env}-ssh-key"
    vpc_security_group_ids = [
      "${aws_security_group.default-security-group.id}"
    ]
    subnet_id = aws_subnet.public-subnet.id
    associate_public_ip_address = "true"
    root_block_device {
      volume_type = "gp2"
      volume_size = "10"
    }
    tags = {
        Name = "${var.env}-proxy01"
    }
}