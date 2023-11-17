#vpc: very_cool_vpc
resource "aws_internet_gateway" "very_cool_gateway"{
    vpc_id = aws_vpc.very_cool_vpc.id
    tags {
      Name = "very_cool_vpc"
    }
}
resource "aws_route_table" "very_cool_table" {
    vpc_id = aws_vpc.very_cool_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.very_cool_gateway.id
    }
    tags {
      Name = "public_route_table"
    }
}
resource "aws_route_table_association" "very_cool_association" {
    subnet_id = aws_subnet.subnetpub.id
    route_table_id = aws_route_table.very_cool_table.id
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



        
