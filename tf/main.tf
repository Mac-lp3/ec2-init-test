terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
  profile = "admin"
}

module "network" {
  source = "./network/"

  environment = var.environment
  sysname     = var.sysname
}

module "instances" {
  source = "./instance"

  environment      = var.environment
  sysname          = var.sysname
  listen_port      = var.listen_port
  public_subnet_id = module.network.public_subnet_id
}