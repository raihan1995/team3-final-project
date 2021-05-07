resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = var.cidr_block
    gateway_id = aws_internet_gateway.gw.id
  }
  route {
    cidr_block = var.cidr_block
    gateway_id = aws_nat_gateway.nat_gate.id
  }
  depends_on = [aws_internet_gateway.gw, aws_nat_gateway.nat_gate]
}
resource "aws_security_group" "web_access" {
  name        = "test"
  description = "allow 8080" # Change to 80!?
  vpc_id      = aws_vpc.myvpc.id
  ingress { #  ingress {} block = general format for creating sg rules - change ports if needed.
    description = "open 8080"
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.myvpc.id
}
resource "aws_nat_gateway" "nat_gate" {
  allocation_id = var.server_public_ip
  subnet_id     = var.subnet_id_a
}
