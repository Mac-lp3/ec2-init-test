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

variable "listen_port" {
  description = "Port where you can hit the server"
  default     = "8000"
}

variable "ssh_key_name" {
  description = "The name of an EXISTING key pair used to ssh into the ec2 box"
  default     = "nginx-ssh-test"
}