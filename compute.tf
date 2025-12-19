resource "aws_key_pair" "key" {
  key_name   = "aws-key"
  public_key = file("./aws-key.pub")
}
resource "aws_instance" "vm" {
  ami                    = "ami-077aec33f15de0896"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.key.key_name
  subnet_id              = data.terraform_remote_state.vpc.outputs.subnet_id
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.security_group]

  associate_public_ip_address = true

  tags = {
    Name = "vm-terraform_001"
  }
}
