resource "aws_instance" "my" {
  
     ami           = "ami-01760eea5c574eb86"
    instance_type = var.instance_type
    key_name = "mykey" 
    subnet_id = "subnet-048962092a00fa9de"
    
    tags = {
        Name = "MyFirstInstance"
    }
}