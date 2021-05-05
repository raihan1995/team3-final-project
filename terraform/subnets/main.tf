resource "aws_subnet" "test" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"
}
resource "aws_internet_gateway" "gate" {
    vpc_id = vars.vpc_id                    # This is defined in VPC/main.tf?
}                                           # Do we need 2 gateways?


resource "aws_eip" "one" {     # not sure what this part is doing - try without
    vpc = true              
    network_interface
}
resource "aws_network_interface" "foo" {
  subnet_id   = aws_subnet.test.id
  private_ips = ["10.0.1.50"]
  security_groups = # need to get the security group ids from VPC/main
}
