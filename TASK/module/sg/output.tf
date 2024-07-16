output "sg_out1" {
  value = aws_security_group.sg[*].id
}

output "sg_out2" {
  value = aws_security_group.sg2[*].id
}
