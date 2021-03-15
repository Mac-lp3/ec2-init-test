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
  vpc_id           = module.network.vpc_id
  public_subnet_id = module.network.public_subnet_id
  ssh_key_name     = var.ssh_key_name
}