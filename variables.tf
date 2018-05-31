variable "env" {}

data "aws_region" "current" {
  default = "us-east-1"
}

variable "vpc_cidr_first_three" {
  default = "10.99.99"
}
