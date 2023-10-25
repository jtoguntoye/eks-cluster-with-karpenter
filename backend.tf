terraform {
  backend "s3" {
    bucket = "cityallies-newbucket"
    key    = "aws-terraform-vpc-dev-tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}