
#Network
/*
  - VPC: 10.0.0.0/16
  - Subnet1: 10.0.10.0/24
  - Subnet2: 10.0.20.0/24
  - Subnet3: 10.0.30.0/24

  - Internet Gateway
  - RouteTable
*/


resource "aws_vpc" "youtube" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "youtube-vpc"
  }
}

resource "aws_subnet" "youtube_sub1" {
  vpc_id            = aws_vpc.youtube.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "youtube_subnet1"
  }
}

resource "aws_subnet" "youtube_sub2" {
  vpc_id            = aws_vpc.youtube.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "youtube_subnet2"
  }
}

resource "aws_subnet" "youtube_sub3" {
  vpc_id            = aws_vpc.youtube.id
  cidr_block        = "10.0.30.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "youtube_subnet3"
  }
}

resource "aws_internet_gateway" "youtube_igw" {
  vpc_id = aws_vpc.youtube.id
  tags = {
    Name = "youtube_igw"
  }

}

resource "aws_route_table" "youtube_rt" {
  vpc_id = aws_vpc.youtube.id
  route {
    cidr_block = "0.0.0.0/24"
    gateway_id = aws_internet_gateway.youtube_igw.id
  }

  tags = {
    Name = "youtube_rt"
  }
}

resource "aws_route_table_association" "youtube_sub1" {
  subnet_id      = aws_subnet.youtube_sub1.id
  route_table_id = aws_route_table.youtube_rt.id

}

resource "aws_route_table_association" "youtube_sub2" {
  subnet_id      = aws_subnet.youtube_sub2.id
  route_table_id = aws_route_table.youtube_rt.id

}

resource "aws_route_table_association" "youtube_sub3" {
  subnet_id      = aws_subnet.youtube_sub3.id
  route_table_id = aws_route_table.youtube_rt.id

}

resource "aws_security_group" "youtube_sg" {
  name        = "youtube_sg"
  description = "Allow inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.youtube.id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}