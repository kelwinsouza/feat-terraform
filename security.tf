resource "aws_security_group" "security_group" {
  name        = "asecurity_group_terraform_3"
  description = "permitir acesso na porta 22"
  vpc_id      =  aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["191.197.130.231/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "security_group_terraform_001"
  }
}