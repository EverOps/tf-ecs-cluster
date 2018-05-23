# tf-ecs-cluster
Terraform module that creates a VPC and ECS cluster

This is a barebones VPC that has the minimal configuration needed to run a Fargate ECS cluster's tasks.
Two private subnets are created with a NAT and a single public subnet is created for the NAT gateway.

# Usage
```
module "vpc" {
  source = "github.com/everops/tf-ecs-cluster"
  env    = "test"
}
```

It is required that you specify the following items:

*env* - environment name. This value will be prepended to all resources created.

You may optionally specify the following items:

*vpc_cidr_first_three* - First 3 numbers of the CIDR to use when creating the VPC. For example. If 10.10.10 is supplied, 10.10.10.0/24 will be used as the VPC CIDR.