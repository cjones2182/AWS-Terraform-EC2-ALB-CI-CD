#====================================================
#alb Security Group
#====================================================

resource "aws_security_group" "alb_security_group" {
  name        = "ALB-Security-Group"
  description = "Allow port 80 for apache"
  vpc_id      = var.vpc_id

  tags = {
    Name = "alb-sg"
  }
}
resource "aws_vpc_security_group_ingress_rule" "alb_ingress_rule" {
  security_group_id = aws_security_group.alb_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "alb_egress" {
  security_group_id = aws_security_group.alb_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

#===============================================================
# EC2 Security Group
#===============================================================

resource "aws_security_group" "instance_security_group" {
  name        = "instance-Security-Group"
  description = "Allow port 80 from alb"
  vpc_id      = var.vpc_id

  tags = {
    Name = "instance-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "instance_ingress_rule" {
  security_group_id = aws_security_group.instance_security_group.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
  referenced_security_group_id = aws_security_group.alb_security_group.id
}


resource "aws_vpc_security_group_egress_rule" "instance_egress" {
  security_group_id = aws_security_group.instance_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}
