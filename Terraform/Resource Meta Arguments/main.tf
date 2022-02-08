/*terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}*/

# Configure the AWS Provider
provider "aws" {
  version = "~> 2.65"
  region = "us-east-1"
  
}

provider "aws" {
  alias = "east"
  region = "us-east-2"
  
  
  
}

resource "aws_instance" "web_east" {
  provider = aws.east
  ami = "ami-0629230e074c580f2"
  instance_type = "t2.micro"

  tags =  {
    Name = "east-2 instance"

  }
}


resource "aws_instance" "web" {
  #ami           = "ami-061ac2e015473fbe2"
  for_each = {
    prod = "t2.large"
    dev = "t2.micro"
  }
  ami           = "ami-0b0af3577fe5e3532"
  instance_type = each.value
  #count = "2"
  key_name = "aws-devops"
  tags = {
      Name ="terraform-ec2instance ${each.key}"
      foo = "bar"

  }

  lifecycle {
    #create_before_destroy = true
    #prevent_destroy = true # prevents to destroy aws resource like databases to save/store data permanently and s3 bucket
    ignore_changes = [
      tags
    ]

  }

}

#output "instance" {
  #value = aws_instance.web[0].public_ip for index 0 Ip 
  #value = aws_instance.web[*].public_ip # for all instance ips it will return list 
  #value = [for instance in aws_instance.web : instance.public_ip]
  
#}#

output "instance" {
  value = aws_instance.web["prod"].public_ip # for index 0 Ip 
  #value = aws_instance.web[*].public_ip # for all instance ips it will return list 
  #value = [for instance in aws_instance.web : instance.public_ip]
  
}



#