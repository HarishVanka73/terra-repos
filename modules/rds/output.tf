output "rds_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.name-rds.endpoint
}

output "rds_instance_id" {
  description = "The RDS instance ID"
  value       = aws_db_instance.name-rds.id
}

output "rds_db_name" {
  description = "The database name"
  value       = aws_db_instance.name-rds.db_name
}


output "rds_security_group_id" {
  description = "The security group attached to RDS"
  value       = aws_security_group.sg-db.id
}

output "aws_subnet_group_id" {
  value = aws_db_subnet_group.sub_grp.id
}