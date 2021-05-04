variable "sub1" {
    description = "subnet id from vpc"
}
variable "sub2" {
    description = "subnet id from vpc"
}
variable "sg_id" {
    description = "security group id"
}
variable "instance_type" {
    default = ["t2.micro"]
}
variable "ami_type" {
    description = "Im not sure I want this part."
    default = "AL2_x86_64"
}
