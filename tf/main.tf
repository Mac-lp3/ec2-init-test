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