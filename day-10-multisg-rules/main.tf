resource "aws_security_group" "name" {
    name = "devops-project-sg"
    description = "Security group for DevOps project"
    ingress = [ 
              for port in [22,80,443,8080,9000,9090] : {
                description = "Allow inbound traffic on port"
                  from_port   = port
                  to_port     = port
                  protocol    = "tcp"
                  cidr_blocks = ["0.0.0.0/0"]
                  ipv6_cidr_blocks = []
                  prefix_list_ids = []
                  security_groups = []
                  self = false
                }
     ]
   egress = [ {
                    description = "Allow all outbound traffic"
                  from_port   = 0
                  to_port     = 0
                  protocol    = "-1"
                  cidr_blocks = ["0.0.0.0/0"]
                    ipv6_cidr_blocks = []
                    prefix_list_ids = []
                    security_groups = []
                    self = false
                    
  
}
   ]
}