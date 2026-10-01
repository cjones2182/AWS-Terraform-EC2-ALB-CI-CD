

data "aws_ami" "amazon_ami" {
  most_recent      = true
   owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.12.20260928.0-kernel-6.18-x86_64"]
  }
}

resource "aws_instance" "instance" {
  ami           = data.aws_ami.amazon_ami.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [ var.instance_security_group ]
  subnet_id = var.private_subnet_1


  user_data = <<-EOF
  #!/bin/bash
  dnf update -y
  dnf install httpd -y
  systemctl enable --now httpd
  echo "welcome" > /var/www/html/index.html
  systemctl restart httpd 
  EOF
  tags = {
    Name = "Instance"
  }
}