#########################[ TARGET GROUP ]###########################

resource "aws_lb_target_group" "tg" {
  name     = "nida-tg"
  port     = var.tg_port
  target_type = "instance"
  protocol = "HTTP"
  vpc_id   = var.vpc_id[0]

  tags = {
    
    Name = var.tg_name
  }


}


resource "aws_lb_target_group" "tg2" {
  name     = "nida-tg"
  provider = aws.west
  port     = var.tg_port
  target_type = "instance"
  protocol = "HTTP"
  vpc_id   = var.vpc_id[1]

  tags = {
    
    Name = var.tg_name
  }


}



resource "aws_lb_target_group_attachment" "tg-atch" {
  count=1
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.ec2-id1[0]
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg-atch2" {
  count=1
  target_group_arn = aws_lb_target_group.tg2.arn
  provider = aws.west
  target_id        = var.ec2-id2[0]
  port             = 80
}