output "vpc_id" {
    value = aws_vpc.prod-vpc.id
}
output "route_id" {
    value = aws_route_table.prod-route-table.id
}
output "sec_group_id" {
    value = aws_security_group.all_web.id
}
output "internet_gateway" {
    value = aws_internet_gateway.gw
}