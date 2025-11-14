
module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/20"
}
module "ec2" {  
  source      = "./modules/ec2"
  instance_type = "t2.micro"
  ami_id       = "ami-03695d52f0d883f65"
    subnet_id    = module.vpc.subnet_1_id
    security_group = module.vpc.security_group_id

    
  
}
