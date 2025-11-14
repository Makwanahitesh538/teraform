resource "aws_instance" "name" {
       ami = var.ami
       instance_type = var.instance_type
       key_name = var.key_name
       subnet_id = "subnet-0fe90fae97ec2eb1f"
        tags = {
          Name = "MyInstance"
        }   
}
