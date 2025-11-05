terraform {
  backend "s3" {
    bucket = "hiteshbhaualltimegreatofthebuckets"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
