resource "aws_subnet" "test_a" {
  vpc_id            = var.vpc_id
  map_public_ip_on_launch = true
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.av_zone[0]
}
resource "aws_subnet" "test_b" {
  vpc_id            = var.vpc_id
  map_public_ip_on_launch = true
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.av_zone[1]
}
resource "aws_eip" "one" {
  vpc               = true
  network_interface = aws_network_interface.ENI_A.id
  depends_on        = [aws_network_interface.ENI_A]
}
# resource "aws_network_interface" "ENI_A" { # 
#   subnet_id       = aws_subnet.public_a.id
#   private_ips     = ["10.0.1.50"]
#   security_groups = [var.security_group_id]
# }
# resource "aws_network_interface" "ENI_B" { # 
#   subnet_id       = aws_subnet.public_b.id
#   private_ips     = ["10.0.1.50"]
#   security_groups = [var.security_group_id]
# }
resource "aws_route_table_association" "A" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = var.route_table_id
}
resource "aws_route_table_association" "B" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = var.route_table_id
}
