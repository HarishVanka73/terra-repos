output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.name-alb.dns_name
}

output "alb_arn" {
  description = "The ARN of the ALB"
  value       = aws_lb.name-alb.arn
}

output "alb_target_group_arn" {
  description = "The ARN of the ALB Target Group"
  value       = aws_lb_target_group.tg-alb.arn
}

output "alb_security_group_id" {
  description = "The security group attached to ALB"
  value       = aws_security_group.alb-sg.id
}
