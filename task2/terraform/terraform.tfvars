########################[security]######################


sg2_name = "nida_sec_grp"



vpc_id = "vpc-0083fad0c8e2a4f47"

sg2_cidr_blocks = ["0.0.0.0/0"]
sg2_tags = {
  Name = "nida-c-sg"
}



##########################[EC2]################


type = "t2.micro"

key1 = "cl"

subnet-id = "subnet-0fcb7845f63912bfd"


