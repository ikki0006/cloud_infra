# Create a VPC
#aws上はtagsのNameの名前が優先させる。
resource "aws_vpc" "main-vpc"{
  cidr_block = var.vpc_cidr

  tags = {
      Name = "${var.env}-vpc"
  }
}

resource "aws_internet_gateway" "main-gw" {
    vpc_id = aws_vpc.main-vpc.id
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-northeast-1a"
}

resource "aws_route_table" "public-route" {
    vpc_id = aws_vpc.main-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main-gw.id
    }
}

resource "aws_security_group" "default-group" {
    name = "admin"
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