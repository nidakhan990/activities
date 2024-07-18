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

resource "aws_instance" "bestion" {
  ami           = data.aws_ami.ubuntu.id
  vpc_security_group_ids = [var.sg_id2]
  instance_type = var.type
  key_name = var.key1
connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("/home/nida/Downloads/cl.pem")
    host     = self.public_ip
  }

  

  provisioner "file" {
    source      = "/home/nida/Videos/activities/data-processing"
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
    
    Name = "nida-bestion-ec2"
  }
}



resource "aws_instance" "private_ec2" {
  ami           = data.aws_ami.ubuntu.id
  vpc_security_group_ids = [var.sg_id2]
  instance_type = var.type
  key_name = var.key1
  subnet_id = var.subnet-id
  associate_public_ip_address= false
  iam_instance_profile =  var.instance_profile
  

  tags = {
    
    Name = "nida-priv-ec2"
  }
}