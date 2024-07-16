#########################[ sg ]###########################

resource "aws_security_group" "sg2" {
  count = 1
  name        = "nida_sg2"
  provider = aws.west
  description = "SG module Achintha Bandaranaike"
  vpc_id = var.vpc_id[1]

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "nida-M-sg"
  }

}

resource "aws_security_group" "sg" {
  count = 1
  name        = "nida_sg"
  provider = aws
  description = "SG module Achintha Bandaranaike"
  vpc_id = var.vpc_id[0]

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "nida-V-sg"
  }

}

#########################[ ami ]###########################

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-*"]
    
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["amazon"] 
}

data "aws_ami" "ubuntu2" {
  most_recent = true
  provider = aws.west

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-*"]
    
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["amazon"] 
}



#########################[ EC2 ]###########################

resource "aws_instance" "web" {
  count = 2
  ami           = data.aws_ami.ubuntu.id
  vpc_security_group_ids = aws_security_group.sg[*].id
  instance_type = "t2.micro"
  key_name = "ndatask"
connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("/home/nida/Downloads/ndatask.pem")
    host     = self.public_ip
  }

  

  provisioner "file" {
    source      = "/home/nida/Videos/TASK/nginx-role"
    destination = "/tmp/nginx-role"
  }

#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt update",
#       "sudo apt install ansible -y",
#       "ansible-playbook /tmp/nginx-role/site.yml"

#     ]
#   }

  tags = {
    
    Name = "nida-nginx-${count.index}"
  }
}



resource "aws_instance" "webs" {
  count = 2
  ami           = data.aws_ami.ubuntu2.id
  provider = aws.west
  vpc_security_group_ids = aws_security_group.sg2[*].id
  instance_type = "t2.micro"
  key_name = "cl"
  
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("/home/nida/Downloads/cl.pem")
    host     = self.public_ip
  }

  provisioner "file" {
    source      = "/home/nida/Videos/TASK/nginx-role"
    destination = "/tmp/"
  }

#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt update",
#       "sudo apt install ansible -y",
#       "ansible-playbook /tmp/nginx-role/site.yml"

#     ]
#   }

  tags = {
    
    Name = "nida-nginx-${count.index}"
  }

}

#########################[ TARGET GROUP ]###########################

resource "aws_lb_target_group" "tg" {
  name     = "nida-tg"
  port     = 80
  target_type = "instance"
  protocol = "HTTP"
  vpc_id   = var.vpc_id[0]

  tags = {
    
    Name = "nida-tg"
  }


}


resource "aws_lb_target_group" "tg2" {
  name     = "nida-tg"
  provider = aws.west
  port     = 80
  target_type = "instance"
  protocol = "HTTP"
  vpc_id   = var.vpc_id[1]

  tags = {
    
    Name = "nida-tg"
  }


}



resource "aws_lb_target_group_attachment" "tg-atch" {
  count=1
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.web[count.index].id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg-atch2" {
  count=1
  target_group_arn = aws_lb_target_group.tg2.arn
  provider = aws.west
  target_id        = aws_instance.webs[count.index].id
  port             = 80
}

#########################[ LOAD BALANCER ]###########################


resource "aws_lb" "lb" {
  name               = "nida-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg[0].id]
  subnets            = ["subnet-0166b6303db4a3dea","subnet-08f86971fff227547"]

  enable_deletion_protection = true

  tags = {
    NAME = "NIDA-ALB"
  }
}

resource "aws_lb" "lb2" {

  name               = "nida-lb-tf2"
  provider = aws.west
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg2[0].id]
  subnets            = ["subnet-0d9802057933d287f","subnet-0606dce3f7476f322"]

  enable_deletion_protection = true

  tags = {
    NAME = "NIDA-ALB"
  }
}




resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}


resource "aws_lb_listener" "front_endd" {  
  provider = aws.west
  load_balancer_arn = aws_lb.lb2.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg2.arn
  }
}


