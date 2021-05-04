resource "aws_vpc" "prod-vpc" {
    cidr_block = var.cidr_block
}
resource "aws_route_table" "prod-route-table" {
    vpc_id = aws_vpc.prod-vpc.id
    route {
        cidr_block = #
        gateway_id = #
    }
}
resource "aws_security_group" "allow_web" {
    name = "allow _web"
    description = "Allow connection over web"
    vpc_id = aws_vpc.prod-vpc.id
}
resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.prod-vpc.id
}
