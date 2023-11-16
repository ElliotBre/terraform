provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.instance_region
}

resource "aws_security_group" "security-group1" {
  name = "security-group1"
  ingress {
    description = "Allows ssh in"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0505148b3591e4c07"
  instance_type = var.instance_name
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.security-group1.id]
  tags = {
    Name = var.instance_name
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  tags = {
    Name = var.bucket_name
  }
}

