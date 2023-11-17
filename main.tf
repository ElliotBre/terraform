provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.instance_region
}
# vpc config
resource "aws_vpc" "very_cool_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
}
#subnets
resource "aws_subnet" "subnetpub" {
  vpc_id                  = aws_vpc.very_cool_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-2b"
  tags = {
    Name = "publicSub"
  }
}
resource "aws_subnet" "subnetpriv" {
  vpc_id            = aws_vpc.very_cool_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-2b"
  tags = {
    Name = "privateSub"
  }
}
#vpc resources
resource "aws_instance" "web" {
  ami                    = "ami-0505148b3591e4c07"
  instance_type          = var.instance_type
  key_name               = var.key_name
  network_interface {
    network_interface_id = aws_network_interface.very_cool_interface.id
    device_index         = 0
  }
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

