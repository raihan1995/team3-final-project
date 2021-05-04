provider "aws" {
  region = "eu-west-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

module "ec2" {
  source             = "./ec2"
  net_id             = module.subnets.net_id
#  ami_id             = ##########################
  instance_type      = "t2.micro"
  av_zone            = "eu-west-2a"
#  key_name           = #########################
}

module "subnets" {
  source             = "./subnets"
  vpc_id             = module.vpc.vpc_id
  route_id           = module.vpc.route_id
  security_group_id  = module.vpc.security_group_id
#  net_private_ips    = ##########################
  internet_gateway   = module.vpc.internet_gateway
    
}
module "VPC" {
  source             = "./vpc"
}