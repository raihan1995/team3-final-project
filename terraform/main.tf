provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}
module "ec2" {
  source        = "./ec2"
  ami_id        = "ami-0194c3e07668a7e36" # "Ubuntu 20.04, eu-west-2"
  instance_type = "t2.micro"
  av_zone       = "eu-west-2a"
  key_name      = "asdf"
  net_id        = module.subnets.net_id
}
module "vpc" {
  source     = "./vpc"
  cidr_block = "0.0.0.0/0"
}
module "subnets" {
  source            = "./subnets"
  vpc_id            = module.vpc.vpc_id
  av_zone           = "eu-west-2a"
  security_group_id = module.vpc.security_group_id
  route_table_id    = module.vpc.route_table_id
}
module "EKS" {
  source            = "./eks"
  subnet_id         = module.subnets.subnet_id
  security_group_id = module.vpc.security_group_id
  instance_types    = ["t2.micro"] ########################## CHANGE TO SOMETHING BIGGER.
}
