terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  #region = "us-east-1"
  region = var.region
}

locals {
  instance_name  = "${terraform.workspace}-instance"
  
}
resource "aws_instance" "web" {
  #ami           = "ami-061ac2e015473fbe2"
   #ami           = "ami-0b0af3577fe5e3532"
   ami = var.ami

  instance_type = var.instance_type
  key_name = "aws-devops"
  tags = {
      Name = local.instance_name
      foo = "bar"

  }
}


#