terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.45.0"
    }
  }
}

provider "aws" {
  #configuration options
  region = "us-east-1"
  # access_key = ""
  # secret_key = ""
}

resource "aws_instance" "tf-ec2" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  tags = {
    "owner" = "bronze"
    "cost"  = "101"
    "name"  = "tf-ec2"
  }
  count = 3
}

resource "aws_s3_bucket" "tf-b" {
  bucket = "bronze-tf-bucket-1"

  tags = {
    Name        = "Bronze bucket"
    Environment = "Dev"
  }
}
