resource "aws_instance" "my" {
  
     ami           = "ami-0d176f79571d18a8f"
    instance_type = var.instance_type
    key_name = "mykey" 
    subnet_id = "subnet-0fe90fae97ec2eb1f"
    
    tags = {
        Name = "MyFirstInstance"
    }
}
