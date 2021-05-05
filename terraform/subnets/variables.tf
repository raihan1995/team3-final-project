variable "vpc_id" {
  description = "vpc id - coming from VPC/main.tf"
}
variable "route_id" {
}
variable "security_group_id" {
  description = "from VPC/main.tf"
  type        = list(any)
}
variable "internet_gateway" {
  description = "from VPC/main.tf"
}
variable "net_private_ips" {
  description = "????"
}
variable "route_table_id" {
  description = "from VPC/main.tf"
}
