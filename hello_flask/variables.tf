data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["*hvm-ssd*-16.04*"]
  }

  owners = ["099720109477"] # Canonical
}

variable "instance_size" {
  default = "t2.micro"
}

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "region" {}

variable "key_name" {
  default = "hello_id_rsa"
}
