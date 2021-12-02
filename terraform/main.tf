provider "aws" {
  profile = "terra"
  region = "us-west-1"
}

resource "aws_instance" "example" {
  ami = "ami-053ac55bdcfe96e85"
  instance_type = "t2.micro"
  
  tags = {
    Name = "terraform-example"
  }
}

