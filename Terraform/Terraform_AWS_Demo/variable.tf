variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

# variable "aws_access_key" {

#   type        = string
#   description = "aws access key"
#   sensitive   = true
# }

# variable "aws_secret_key" {

#   type        = string
#   description = "aws secret key"
#   sensitive   = true
# }

variable "aws_availability_zones" {
  type    = list(string)
  default = ["eu-central-1a"]
}

variable "aws_vpc_cidr" {
  type    = string
  default = "10.1.0.0/16"
}

variable "aws_vpc_name" {
  type    = string
  default = "my-vpc"
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.9.0/24", "10.0.10.0/24"]
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.7.0/24", "10.0.8.0/24"]
}

variable "environment" {
  type   = string
  default = "dev"
}

variable "ami_ubuntu" {
  type        = string
  description = "ami ubuntu"
  default     = "ami-0a0b7b240264a48d7"
}

variable "instance_type" {
  type        = string
  description = "instance type"
  default     = "t2.micro"
  
}

variable "default_security_group_ingress" {
  description = "List of maps of ingress rules to set on the default security group"
  type        = list(map(string))
  default     = []
}

variable "network_interfaces" {
  description = "Customize network interfaces to be attached at instance boot time"
  type        = list(any)
  default     = []
}