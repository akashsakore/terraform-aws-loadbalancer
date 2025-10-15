variable "vpc_name" {
    type = string
    description = "value of vpc name"
}
variable "vpc_cidr_block" {
    type = string
    description = "value of cidr block"
}
variable "public_subnet_cidr" {
    type = list(string)
    description = "value of public subnet cidr"
}
variable "private_subnet_cidr" {
    type = list(string)
    description = "value of private subnet cidr"
}
variable "public_subnet_AZ" {
    type = list(string)
    description = "value of availability zone"
}

variable "instance_type" {
    type = string
    description = "value of instance type"
}
variable "public_key" {
    type = string
    description = "value of public key"
}
variable "public_key_name" {
    type = string
    description = "value of public key name"
  
}
