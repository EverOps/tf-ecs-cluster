resource "aws_ecs_cluster" "fargate" {
  name = "${replace(var.env, ".", "-")}-fargate"
}
