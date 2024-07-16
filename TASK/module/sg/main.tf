#########################[ sg ]###########################

resource "aws_security_group" "sg2" {
  count = 1
  name        = "nida_sg_1"
  provider = aws.west
  description = "SG module Achintha Bandaranaike"
  vpc_id = var.vpc_id[1]

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

resource "aws_security_group" "sg" {
  count = 1
  name        = "nida_sg_2"
  provider = aws
  description = "SG module Achintha Bandaranaike"
  vpc_id = var.vpc_id[0]

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
  tags = var.sg_tags

}