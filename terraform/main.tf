#provider

module "ec2" {
  source         = "./ec2"
  net_id         = module.subnets.net_id
  ami_id         = ##########################
  instance_type  = "t2.micro"
  av_zone        = "eu-west-2a"
  key_name       = #########################

}
module "subnets" {

    
}
module "VPC" {

    
}