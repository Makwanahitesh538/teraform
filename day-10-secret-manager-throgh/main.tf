resource "random_password" "name" {
  length           = 16
  special          = true
  override_special = "!#$%^&*()-_=+[]{}<>:?"
  min_special      = 2
}
resource "aws_secretsmanager_secret" "name" { 
    name             = "my_secret_name"
    description      = "This is my secret managed by Terraform"
    recovery_window_in_days = 7
}
resource "aws_secretsmanager_secret_version" "name" {
        secret_id = aws_secretsmanager_secret.name.id
        secret_string = random_password.name.result

}
resource "aws_db_instance" "name" {
    identifier = "my-rds"

  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "mydatabase"

  username             = "admin"
  password             = aws_secretsmanager_secret_version.name.secret_string

  db_subnet_group_name = aws_db_subnet_group.name.id


  skip_final_snapshot  = true
}

resource "aws_subnet" "db_subnet_1" {
  vpc_id            = "vpc-01fcde2b02a1c58a5"
  cidr_block        = "10.0.10.0/24"
  availability_zone = "ap-south-1a"
}

resource "aws_subnet" "db_subnet_2" {
  vpc_id            = "vpc-01fcde2b02a1c58a5"
  cidr_block        = "10.0.11.0/24"
  availability_zone = "ap-south-1b"
}
resource "aws_db_subnet_group" "name" {
    name       = "my_db_subnet_group"
    subnet_ids = [aws_subnet.db_subnet_1.id, aws_subnet.db_subnet_2.id]
    description = "Subnet group for RDS instance"
}
