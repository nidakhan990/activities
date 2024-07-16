########################[security]######################

variable "sg2_name" {
  description = "Name of the security group"
  type        = string

}


variable "vpc_id" {
  type = list(string)

}

variable "sg2_cidr_blocks" {
  description = "CIDR blocks for ingress and egress rules"
  type        = list(string)

}

variable "sg2_tags" {
  description = "Tags for the security group"
  type        = map(string)

}

variable "sg_tags" {
  description = "Tags for the security group"
  type        = map(string)

}


##########################[EC2]################

variable "type" {
  type    = string
  

}

variable "key1" {
  type = string
  
  
}

variable "key2" {
  type = string
  
  
}


##########################[TARGET GROUP]################



variable "tg_port" {
  type = number

}

variable "tg_name" {
  type = string

}


##########################[loadbalncer]################


variable "sub_id2" {
  type = list(string)

}

variable "sub_id1" {
  type = list(string)

}

variable "lb-name" {
  type = string

}