resource "aws_subnet" "public" {
  vpc_id            = vars.vpc_id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"
}
resource "aws_eip" "one" {
  vpc               = true
  network_interface = aws_network_interface.foo.id
  depends_on        = [aws_network_interface.foo]
}
resource "aws_network_interface" "foo" {
  subnet_id       = aws_subnet.public.id
  private_ips     = ["10.0.1.50"]
  security_groups = vars.security_group_id
}
resource "aws_route_table_association" "A" {
  # count = length(var.subnets_cidr) ?? count = 1??? unneccessary.
  subnet_id      = aws_subnet.public.id
  route_table_id = vars.route_table_id
}
