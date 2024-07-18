variable "sg2_name" {
  description = "Name of the security group"
  type        = string
  
}


variable "vpc_id" {
  type = string
 
}

variable "sg2_cidr_blocks" {
  description = "CIDR blocks for ingress and egress rules"
  type        = list(string)
  
}

variable "sg2_tags" {
  description = "Tags for the security group"
  type        = map(string)
 
}