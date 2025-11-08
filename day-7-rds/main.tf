resource "aws_db_instance" "name" {
    allocated_storage = 10 
    instance_class = "db.t3.micro"
    identifier = "mydbinstance"
    engine = "mysql"
    db_name = "mydatabase"
    engine_version = "8.0"  
    username = "admin"  
    password = "password123"
    parameter_group_name = "default.mysql8.0"  
    db_subnet_group_name = aws_db_subnet_group.sub-grp.id 
    skip_final_snapshot = true
    depends_on = [ aws_db_subnet_group.sub-grp ]



}
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "dev"
    }
  
}
resource "aws_subnet" "subnet-1" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"
  
}
resource "aws_subnet" "subnet-2" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1b"
  
}
resource "aws_db_subnet_group" "sub-grp" {
  name       = "mycutsubnet"
  subnet_ids = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]

  tags = {
    Name = "My DB subnet group"
  }
}
resource "aws_secretsmanager_secret_version" "name" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = aws_db_instance.name.username
    password = aws_db_instance.name.password
  })  
  
}
resource "aws_secretsmanager_secret" "db_credentials" {
  name = "db_credentials"
  
}

