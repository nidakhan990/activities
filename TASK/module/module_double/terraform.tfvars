########################[security]######################


sg2_name = "nida_sec_grp"



vpc_id = ["vpc-0bd77be963de9201c", "vpc-0083fad0c8e2a4f47"]

sg2_cidr_blocks = ["0.0.0.0/0"]
sg2_tags = {
  Name = "nida-c-sg"
}

sg_tags = {
  Name = "nida-v-sg"
}



##########################[EC2]################


type = "t2.micro"

key1 = "ndatask"
key2= "cl"




##########################[TARGET GROUP]################



tg_port = 80

tg_name = "nida-tg"




##########################[loadbalncer]################




sub_id1 = ["subnet-0166b6303db4a3dea", "subnet-08f86971fff227547"]
sub_id2 = ["subnet-0d9802057933d287f", "subnet-0606dce3f7476f322"]

lb-name = "NIDA-ALB"