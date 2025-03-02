output "public-sub-1-id" {
  value = aws_subnet.sub-all["public-sub-1"].id
}

output "public-sub-2-id" {
  value = aws_subnet.sub-all["public-sub-2"].id
}

output "private-sub-1-id" {
  value = aws_subnet.sub-all["private-sub-1"].id
}

output "private-sub-2-id" {
  value = aws_subnet.sub-all["private-sub-2"].id
}

output "vpc_id" {
  value = data.aws_vpc.name-vpc.id
}