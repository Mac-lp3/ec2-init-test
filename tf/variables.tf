variable "sysname" {
  description = "The name of the whole system/app"
  default     = "ec2app"
}

variable "region" {
  description = "AWS Deployment region."
  default     = "us-east-1"
}

variable "environment" {
  description = "The target env this code will be deployed into"
  default     = "dev"
}