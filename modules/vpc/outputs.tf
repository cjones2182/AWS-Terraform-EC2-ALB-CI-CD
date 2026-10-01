output "vpc_id" {
  description = "id of vpc"
  value = aws_vpc.main.id
}

output "public_subnet_1" {
  description = "public subnet"
  value = aws_subnet.public_subnet_1.id
}

output "public_subnet_2" {
  description = "public subnet 2"
  value = aws_subnet.public_subnet_2.id
}
output "private_subnet_1" {
  description = "private subnet"
  value = aws_subnet.private_subnet_1.id
}