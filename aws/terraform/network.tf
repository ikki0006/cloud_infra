# Create a VPC
#aws上はtagsのNameの名前が優先させる。
resource "aws_vpc" "main-vpc"{
  cidr_block = var.vpc-cidr
  tags = {
      Name = "${var.env}-vpc"
  }
}

resource "aws_internet_gateway" "main-gw" {
    vpc_id = aws_vpc.main-vpc.id
    tags = {
      Name = "${var.env}-gw"
    }
    
}

resource "aws_subnet" "public-subnet01" {
    vpc_id = aws_vpc.main-vpc.id
    cidr_block = var.public-cidr01
    availability_zone = "ap-northeast-1a"
    tags = {
      Name = "${var.env}-public-subnet01"
    }
}

resource "aws_subnet" "public-subnet02" {
    vpc_id = aws_vpc.main-vpc.id
    cidr_block = var.public-cidr02
    availability_zone = "ap-northeast-1c"
    tags = {
      Name = "${var.env}-public-subnet02"
    }
}

resource "aws_route_table" "public-route" {
    vpc_id = aws_vpc.main-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main-gw.id
    }
    tags = {
      Name = "${var.env}-route"
    }
}

resource "aws_route_table_association" "public01_association" {
  subnet_id = aws_subnet.public-subnet01.id
  route_table_id = aws_route_table.public-route.id
}