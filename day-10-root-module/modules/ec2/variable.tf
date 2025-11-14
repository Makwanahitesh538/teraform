variable "ami_id" {
    description = "The AMI ID for the EC2 instance"
    type        = string
    default     = ""

  
}
variable "instance_type" {
    description = "The instance type for the EC2 instance"
    type        = string
    default     = ""

  
}
variable "subnet_id" {
    description = "The subnet ID where the EC2 instance will be launched"
    type        = string
    default     = ""

  
}
variable "security_group" {
    description = "The security group for the EC2 instance"
    type        = string
    default     = ""

  
}