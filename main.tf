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
resource "aws_vpc" "very_cool_vpc"{
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
}
resource "aws_subnet" "subnetpub"{
    vpc_id = aws_vpc.very_cool_vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-west-2b"
    tags {
      Name = "publicSub"
    }
}
resource "aws_subnet" "subnetpriv" {
    vpc_id = aws_vpc.very_cool_vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "eu-west-2b"
    tags {
      Name = "privateSub"
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

