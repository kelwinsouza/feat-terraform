resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "vpc-terraform-001"
    }
}
resource "aws_subnet" "subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"

    tags = {
        Name= "Subnet_terraform_001"
}
}
resource "aws_internet_gateway" "gateway" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name ="aws_internet_gateway_001"
    }
  
}
resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.main.id
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.geteway.id
  }
  tags = {
    Name = "route_table_001"
  }
}
