
resource "aws_security_group" "sg-1" {
  vpc_id = var.vpc_id
  name   = var.sg-name

  ingress {
    description = "allow ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "http traffic flow"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    description = "allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

locals {
  instance_name = "${terraform.workspace}-instance"
}



resource "aws_instance" "ec2-pub-1" {
  for_each                    = var.instance_values
  ami                         = each.value.ami
  instance_type               = each.value.instance_type
  key_name                    = each.value.key_name
  associate_public_ip_address = each.value == "public" ? true : false
  security_groups             = [aws_security_group.sg-1.name]


  tags = {
    name = "${local.instance_name}-${each.key}-ha"
  }

}

