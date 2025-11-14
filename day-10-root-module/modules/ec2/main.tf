resource "aws_instance" "name" {
    ami           = var.ami_id
    instance_type = var.instance_type
    subnet_id     = var.subnet_id
    security_groups = [var.security_group]

    tags = {
        Name = "My-EC2-Instance"
    }
  
}