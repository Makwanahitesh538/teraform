
module "name" {
    source = "../day-9-module"
    key_name = "mykey"
  
    ami="ami-0305d3d91b9f22e84"
    instance_type="t2.micro"
    



}