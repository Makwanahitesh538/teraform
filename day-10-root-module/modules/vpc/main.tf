resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "subnet-1"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "subnet-2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"               # FIXED
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "main-rtb"
  }
}

resource "aws_route_table_association" "rta_1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.rtb.id
}

resource "aws_route_table_association" "rta_2" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.rtb.id
}

resource "aws_security_group" "sg_1" {
  name        = "sfg-1"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-http-ssh"
  }
}
