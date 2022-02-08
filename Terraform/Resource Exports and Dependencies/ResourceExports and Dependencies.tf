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
  region = "us-east-1"
}

/*

for subnet it needs vpc passed value using resource 

*/

resource "aws_vpc" "main" {
   cidr_block = "10.5.0.0/16"

   tags = {
      Name ="hello vpc "
  }
}

resource "aws_subnet" "web-subnet" {
    vpc_id =  aws_vpc.main.id
    cidr_block = "10.5.0.0/16"
    tags = {
        Name ="web-subnet "
    }
}

# for aws instance  it needs subnet , passed value using resource 
resource "aws_instance" "web" {
   ami           = "ami-0b0af3577fe5e3532"
  instance_type = "t2.large"
  subnet_id = aws_subnet.web-subnet.id
  count = "1"
  key_name = "aws-devops"
  tags = {
      Name ="terraform-ec2instance"
      foo = "bar"

  }
}


#