module "security_grp" {
  source          = "/home/nida/Videos/activities/task2/task2-child-module/security"
  vpc_id          = var.vpc_id
  sg2_cidr_blocks = var.sg2_cidr_blocks
  sg2_name        = var.sg2_name
  sg2_tags        = var.sg2_tags

}

module "iam" {
  source = "/home/nida/Videos/activities/task2/task2-child-module/iamrole"


}


module "ec2" {
  source           = "/home/nida/Videos/activities/task2/task2-child-module/ec2"
  sg_id2           = module.security_grp.sg_out2
  type             = var.type
  key1             = var.key1
  subnet-id        = var.subnet-id
  instance_profile = module.iam.iam_out


}


