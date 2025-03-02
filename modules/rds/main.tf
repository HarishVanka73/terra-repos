

resource "aws_security_group" "sg-db" {
  vpc_id = var.vpc_id
  name   = var.sec-db-name

  ingress {
    description = "allow mysql access"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups =   [var.sec-grp-id]
  }

  egress {
    description = "allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "sub_grp" {
  name       = var.rds-sub-grp
  subnet_ids = [var.private-sub-1-id, var.private-sub-2-id]

  tags = {
    name = var.name-sub-grp
  }
}
resource "aws_db_instance" "name-rds" {
  allocated_storage      = var.storage
  storage_type           = var.vol_type
  instance_class         = var.instance_type
  engine                 = var.engine
  engine_version         = var.engine_version
  identifier =   var.identity
  username               = var.user_id
  password               = var.user_pass
  parameter_group_name   = "default.mysql8.0"
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.sg-db.id]
  db_subnet_group_name = aws_db_subnet_group.sub_grp.id

}