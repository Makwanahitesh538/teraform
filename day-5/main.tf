resource "aws_instance" "name" {
    ami = "ami-01760eea5c574eb86"
    instance_type = "t2.micro"
    subnet_id = "subnet-0b73d4ade37b6c0f6"
  

        tags = {
            Name = "MyFirstInstance"
        }   

}

    resource "aws_s3_bucket" "bucket" {
        bucket = "hiteshbhaualltimegreatofthebuckets"
        
    }
