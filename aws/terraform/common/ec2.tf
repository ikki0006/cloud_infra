resource "aws_instance" "reverse-proxy" {
    ami = var.cent-id
    instance_type = "t2.micro"
    key_name = "${var.env}-proxy"
    vpc_security_group_ids = [
      "${aws_security_group.default-security-group.id}"
    ]
    subnet_id = "${aws_subnet.public-subnet.id}"
    associate_public_ip_address = "true"
    root_block_device = {
      volume_type = "gp2"
      volume_size = "8"
    }
    tags = {
        Name = "${var.env}-proxy01"
    }
}