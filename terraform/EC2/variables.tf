variable "ami_id" {
  description = "id of the ami"
  default = "ami-0194c3e07668a7e36"
}
variable "instance_type" {
  default = ["t2.micro"]
}
variable "av_zone" {
  default = "eu-west-2"
}
variable "key_name" {
  default = "tbc"
}
variable "net_id" {
  description = "???"
}
