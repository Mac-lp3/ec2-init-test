variable "vpc_cidr" {
    description = "CIDR block for the VPC that will contain the EC2"
    default     = "10.0.0.0/26"
}

variable "public_subnet_cidr" {
    description = "CIDR block for the subnet that will contain the EC2"
    default     = "10.0.0.0/28"
}

variable "environment" {}
variable "sysname" {}
