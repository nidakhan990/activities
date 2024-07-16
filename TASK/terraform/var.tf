variable "vpc_id" {
  type = list(string)
  default = ["vpc-0bd77be963de9201c" ,"vpc-0083fad0c8e2a4f47" ]
}

variable "region1" {
  type = string
  default ="us-east-1"
}

variable "region2" {
  type = string
  default ="ap-south-1"
}