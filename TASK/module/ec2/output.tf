output "ec2_out1" {
  value = aws_instance.web[*].id
}

output "ec2_out2" {
  value = aws_instance.webs[*].id
}