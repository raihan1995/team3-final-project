variable "access_key" {
  type        = string
  description = "Enter credentials of aws user with relevent permissions"
}
variable "secret_key" {
  type        = string
  description = "Enter credentials of aws user with relevent permissions"
}
variable "region" {
  type        = string
  description = "aws account region"
  default     = "eu-west-2"
}