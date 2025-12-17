terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.26.0"
    }
  }
  backend "s3" {
    bucket = "value"
    key = "value"
    region = "sa-east-1"
  }

}

provider "aws" {
  region = "sa-east-1"
}