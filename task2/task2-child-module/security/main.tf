#########################[ sg ]###########################

resource "aws_security_group" "sg2" {
  name        = "nida_sg_1"
  description = "SG module Achintha Bandaranaike"
  vpc_id = var.vpc_id

  ingress {
    from_port   = "22" 
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = var.sg2_cidr_blocks
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.sg2_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.sg2_cidr_blocks
  }
  tags = var.sg2_tags

}