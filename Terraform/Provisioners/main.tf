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


resource "aws_instance" "web" {
  #ami           = "ami-061ac2e015473fbe2"
   ami           = "ami-0b0af3577fe5e3532"
  instance_type = "t2.large"
  key_name = "aws-devops"
  tags = {
      Name ="terraform-ec2instance"
      foo = "bar"

  }

  connection {
		type        = "ssh"
		host        = self.public_ip
		user        = "ec2-user"
		private_key = file("C:\\Users\\QC\\Downloads\\aws-devops.pem")
		# Default timeout is 5 minutes
		timeout     = "4m"
	}
  
  /*provisioner "local-exec" {
    #command = "echo ${self.public_ip}" > public_ip.txt
    command = "echo ${self.public_ip} > instance-ip.txt"
    
  }*/
  /*provisioner "file" {
    content     = "hello file exec"
    #source = "instance-ip.txt"
    destination = "/home/ec2-user/sample.txt"
    } 
    */ 

    provisioner "remote-exec" {
      #when = destroy
      #on_failure = "continue"/"fail"
      inline = [
        "touch /home/ec2-user/helloworld.txt"
        
      ]
      
    }

    /*provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/get-public-ip.sh",
      "/tmp/get-public-ip.sh > /tmp/public-ip",
    ]
  }*/

    provisioner "remote-exec" {
      connection {
		type        = "ssh"
		host        = "3.88.162.217"
		user        = "ec2-user"
		private_key = file("C:\\Users\\QC\\Downloads\\aws-devops.pem")
		# Default timeout is 5 minutes
		timeout     = "4m"
	}
      inline = [
        "touch /home/ec2-user/helloworld.txt"
      ]
      
    }

}
output "ip" {
  value = aws_instance.web.public_ip
  
}



#