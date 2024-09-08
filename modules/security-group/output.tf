output "security_group__id" {
  value = aws_security_group.appsg.id
}

output "security_group__id_lb" {
  value = aws_security_group.lbsg.id
}
