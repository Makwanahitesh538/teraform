terraform {
  backend "s3" {
    bucket         = "jrfhewjouehfuqehfdeofhuheiofswufbw"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "test"
    encrypt        = true

     }
}
