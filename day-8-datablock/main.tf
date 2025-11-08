# Generate random password
resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "oireiqjw1132ewddkttfytyyy"
}

# Create a secret to hold DB credentials
resource "aws_secretsmanager_secret" "db_secret" {
  name        = "mydb-secretv2"
  description = "Database credentials for my RDS instance"
}

# Store the generated password inside the secret
resource "aws_secretsmanager_secret_version" "db_secret_value" {
  secret_id = aws_secretsmanager_secret.db_secret.id

  # Create a JSON structure (username + password)
  secret_string = jsonencode({
    username = "admin"
    password = random_password.db_password.result
  })
}

# Fetch default VPC (for subnet lookup)
data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["dev"]
  }
}
data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}


# Create a DB subnet group
resource "aws_db_subnet_group" "name" {
  name       = "my-db-subnet-group"
  subnet_ids = data.aws_subnets.selected.ids

  tags = {
    Name = "My DB subnet group"
  }
}

# Create RDS instance
resource "aws_db_instance" "name" {
  allocated_storage = 20
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  db_name           = "mydatabase"

  # Extract username & password from secret
  username = jsondecode(aws_secretsmanager_secret_version.db_secret_value.secret_string)["username"]
  password = jsondecode(aws_secretsmanager_secret_version.db_secret_value.secret_string)["password"]

  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.name.id

  depends_on = [aws_db_subnet_group.name]
}
