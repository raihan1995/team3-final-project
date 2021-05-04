variable "subnet_1" {
  description = "subnet id from vpc"
}
variable "subnet_2" {
  description = "subnet id from vpc"
}
variable "sg_id" {
  description = "security group id"
}
variable "instance_type" {
  default = ["t2.micro"]
}
