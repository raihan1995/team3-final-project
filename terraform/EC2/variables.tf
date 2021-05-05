variable "ami_id" {
  description = "Ubuntu 20.04, eu-west-2"
  default     = "ami-0194c3e07668a7e36"
}
variable "instance_type" {
  default = ["t2.micro"]
}
variable "av_zone" {
  default = "eu-west-2"
}
variable "key_name" {
  default = "asdf"
}
variable "net_id" {
  description = "Network interface id - Originates from VPC/main.tf"
}
