resource "aws_security_group" "sgrp" {
  name        = "sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-0083fad0c8e2a4f47"

  
  ingress {
    description = "TLS from VPC"
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
    Name = "nida-allow_tls"
  }
}


