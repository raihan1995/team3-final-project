output "vpc_id" {
  value = aws_vpc.myvpc.id
}
output "route_table_id" {
  value = aws_route_table.prod-route-table.id
}
output "security_group_id" {
  value = aws_security_group.web_access.id
}
output "internet_gateway" {
  value = aws_internet_gateway.gw
}