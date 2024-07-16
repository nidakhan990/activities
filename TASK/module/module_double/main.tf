module "security_grp" {
  source          = "/home/nida/Videos/TASK/module/sg"
  vpc_id          = var.vpc_id
  sg2_cidr_blocks = var.sg2_cidr_blocks
  sg_tags         = var.sg_tags
  sg2_name       = var.sg2_name
  sg2_tags       = var.sg2_tags

}

module "ec2" {
  source = "/home/nida/Videos/TASK/module/ec2"
  sg_id1  = module.security_grp.sg_out1
  sg_id2 = module.security_grp.sg_out2
  type   = var.type
  key1    = var.key1
  key2    = var.key2
}

module "target_grp" {
  source  = "/home/nida/Videos/TASK/module/tg"
  vpc_id  = var.vpc_id
  tg_port = var.tg_port
  tg_name = var.tg_name
  ec2-id1 = module.ec2.ec2_out1
  ec2-id2 = module.ec2.ec2_out2


}


module "alb" {
  source  = "/home/nida/Videos/TASK/module/lb"
  sg_id1  = module.security_grp.sg_out1
  sub_id1 = var.sub_id1[*]
  lb-name = var.lb-name
  sg_id2  = module.security_grp.sg_out2
  sub_id2 = var.sub_id2[*]
  tg-arn = module.target_grp.tg_out1
  tg-arn2 = module.target_grp.tg_out2
  

    
  }
  



