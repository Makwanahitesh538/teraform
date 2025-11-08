resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my_custom_vpc"
  }
}
resource "aws_subnet" "name" {
  vpc_id     = aws_vpc.name.id
  cidr_block    = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "my_custom_subnet"

  }
}
resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "my_custom_igw"
  }
}
resource "aws_route_table" "name" {
  vpc_id = aws_vpc.name.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
  }
  tags = {
    Name = "my_custom_route_table"
  }
}
resource "aws_route_table_association" "name" {
  subnet_id      = aws_subnet.name.id
  route_table_id = aws_route_table.name.id
}

resource "aws_security_group" "name" {
  name        = "my_custom_sg"
  description = "Custom security group"
  vpc_id      = aws_vpc.name.id

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
    Name = "my_custom_sg"
  }
}
resource "aws_instance" "name" {
  ami                    = "ami-0305d3d91b9f22e84"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.name.id
  key_name               = "mykey"
  vpc_security_group_ids = [aws_security_group.name.id]
  tags = {
    Name = "MyCustomInstance"
  }
}