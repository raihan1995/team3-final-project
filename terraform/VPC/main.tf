resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_route_table" "prod-route-table" {
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = #### Not sure what this are refering to.
        gateway_id = #### Is this the gateway defined below?
    }
}
resource "aws_security_group" "mysg" {
  name        = "test"
  description = "allow 9876 and 8080"
  vpc_id      = aws_vpc.myvpc.id

  ingress {                         #  ingress {} block = general format for creating sg rules - change ports if needed.
    description = "open 9876"
    protocol    = "tcp"
    from_port   = 9876                  
    to_port     = 9876
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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
