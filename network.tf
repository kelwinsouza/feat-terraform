resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "vpc-terraform-001"
    }
}
resource "aws_subnet" "subnet" {
    vpc_id = aws_vpc.main
    cidr_block = "10.0.1.0/24"

    tags = "Subnet_terrafor_001"
}