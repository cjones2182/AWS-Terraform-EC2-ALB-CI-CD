output "alb_security_group" {
  description = "alb sg"
  value = aws_security_group.alb_security_group.id
}
output "instance_security_group" {
  description = "ec2 security"
    value = aws_security_group.instance_security_group.id
}