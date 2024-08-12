variable "instance_type" {
  type        = string
  description = "Instance type"
  default     = "t2.micro"
}

variable "instance_ami" {
  type        = string
  description = "Instance AMI"
  default     = "ami-4596985695987"

}

variable "create_igw" {
    type = bool
    description = "Instance name"
    default = true  
}

variable "include_ipv4" {
  type = bool
  default = true 
}