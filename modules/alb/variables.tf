variable "public_subnet_1" {
  description = "subnet for alb"
  type = string
}

variable "public_subnet_2" {
  description = "subnet for alb"
  type = string
}
variable "vpc_id" {
  description = "vpc id"
  type = string
}
variable "alb_security_group" {
  default = "alb security group"
  type = string
}
variable "aws_instance" {
  description = "instance for target group"
  type = string
}