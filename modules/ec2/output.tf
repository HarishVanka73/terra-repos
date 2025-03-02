output "instance_id-1" {
  value = aws_instance.ec2-pub-1["instance-pub-1"].id
}

output "instance_id-2" {
  value = aws_instance.ec2-pub-1["instance-pub-2"].id
}
output "sec-grp-id" {
  value = aws_security_group.sg-1.id
}

output "instance_public-ip-1" {
  value = aws_instance.ec2-pub-1["instance-pub-1"].public_ip
}

output "instance_public-ip-2" {
  value = aws_instance.ec2-pub-1["instance-pub-2"].public_ip
}

