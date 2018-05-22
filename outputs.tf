output "cluster_id" {
  value = "${aws_ecs_cluster.fargate.id}"
}

output "nat_subnet_b" {
  value = "${aws_subnet.nat-b.id}"
}

output "nat_subnet_c" {
  value = "${aws_subnet.nat-c.id}"
}

output "internet_subnet" {
  value = "${aws_subnet.internet.id}"
}
