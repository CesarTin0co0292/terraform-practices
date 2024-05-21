variable "instance_type" {
  type        = string
  description = "Instance type"
  default     = "t2.micro"
}

data "aws_region" "current" {
  
}

resource "aws_instance" "ec2_test" {
  ami           = "ami-005e54dee72cc1d00"
  instance_type = var.instance_type
}

resource "aws_instance" "ec2_test_2" {
  ami           = "ami-005e54dee72cc1d01"
  instance_type = var.instance_type
}

output "region" {
  value = data.aws_region.current.name
}