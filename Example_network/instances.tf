resource "aws_instance" "server1" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.youtube_sub1.id
  vpc_security_group_ids = [aws_security_group.youtube_sg.id]
  associate_public_ip_address = var.include_ipv4.id
}

resource "aws_instance" "server2" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.youtube_sub2.id
  vpc_security_group_ids = [aws_security_group.youtube_sg.id]
  associate_public_ip_address = var.include_ipv4.id
}

resource "aws_instance" "server3" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.youtube_sub3.id
  vpc_security_group_ids = [aws_security_group.youtube_sg.id]
  associate_public_ip_address = var.include_ipv4.id
}