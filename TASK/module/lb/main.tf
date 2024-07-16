#########################[ LOAD BALANCER ]###########################


resource "aws_lb" "lb" {
  name               = "nida-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.sg_id1
  subnets            = var.sub_id1

  enable_deletion_protection = false

  tags = {
    NAME = var.lb-name
  }
}

resource "aws_lb" "lb2" {

  name               = "nida-lb"
  provider = aws.west
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.sg_id2
  subnets            = var.sub_id2

  enable_deletion_protection = false

  tags = {
    NAME = var.lb-name
  }
}




resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = var.tg-arn
  }
}


resource "aws_lb_listener" "front_endd" {  
  provider = aws.west
  load_balancer_arn = aws_lb.lb2.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = var.tg-arn2
  }
}


