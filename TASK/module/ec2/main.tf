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
  vpc_security_group_ids = var.sg_id1
  instance_type = var.type
  key_name = var.key1
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
  vpc_security_group_ids = var.sg_id2
  instance_type = var.type
  key_name = var.key2
  
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
