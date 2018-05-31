variable "env" {}

data "aws_region" "current" {}

variable "vpc_cidr_first_three" {
  default = "10.99.99"
}
