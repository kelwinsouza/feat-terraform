resource "aws_key_pair" "key" {
  key_name   = "aws-key"
  public_key = file("./aws-key.pub")
}
resource "aws_instance" "vm" {
  ami                    = "ami-077aec33f15de0896"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.key.key_name
  subnet_id              = aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.security_group.id]

  associate_public_ip_address = true

  tags = {
    Name = "vm-terraform_001"
  }
}
