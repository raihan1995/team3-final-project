#provider

module "ec2" {
  source             = "./ec2"
  net_id             = module.subnets.net_id
  ami_id             = ##########################
  instance_type      = "t2.micro"
  av_zone            = "eu-west-2a"
  key_name           = #########################
}

module "subnets" {
  source             =
  vpc_id             =
  route_id           =
  security_group_id  =
  net_private_ips    =
  internet_gateway   =
    
}
module "VPC" {
  source             = "./vpc"
}