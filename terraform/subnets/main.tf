resource "aws_subnet" "public" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.av_zone
}
resource "aws_eip" "one" {
  vpc               = true
  network_interface = aws_network_interface.foo.id
  depends_on        = [aws_network_interface.foo]
}
resource "aws_network_interface" "foo" {
  subnet_id       = aws_subnet.public.id
  private_ips     = ["10.0.1.50"]
  security_groups = var.security_group_id
}
resource "aws_route_table_association" "A" {
  subnet_id      = aws_subnet.public.id
  route_table_id = var.route_table_id
}
