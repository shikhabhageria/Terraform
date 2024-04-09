terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.44.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "shikha-terraform"
    key    = "tfstate"
    region = "us-west-1"
    dynamodb_table = "tfstate"
  }
}

provider "aws" {
  # Configuration options
  region = "us-west-1"
}