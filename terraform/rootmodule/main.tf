module "security_grp" {
  source = "/home/fateh/task2-role/task3/terraform/sg"
}


module "iam" {
  source = "/home/fateh/task2-role/task3/terraform/iamrole"
}


module "s3" {
  source = "/home/fateh/task2-role/task3/terraform/s3"
}


module "instance" {
  source = "/home/fateh/task2-role/task3/terraform/ec2"
  sg1= module.security_grp.sg-out
  profile=module.iam.profile-0ut
}


