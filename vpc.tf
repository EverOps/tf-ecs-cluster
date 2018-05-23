resource "aws_vpc" "fargate" {
  cidr_block = "${var.vpc_cidr_first_three}.0/24"

  tags {
    Name = "${var.env}.fargate"
  }
}

resource "aws_subnet" "nat-c" {
  vpc_id            = "${aws_vpc.fargate.id}"
  cidr_block        = "${var.vpc_cidr_first_three}.0/26"
  availability_zone = "${data.aws_region.current.name}c"

  tags {
    Name = "${var.env}.fargate.nat-c"
  }
}

resource "aws_subnet" "nat-b" {
  vpc_id            = "${aws_vpc.fargate.id}"
  cidr_block        = "${var.vpc_cidr_first_three}.64/26"
  availability_zone = "${data.aws_region.current.name}b"

  tags {
    Name = "${var.env}.fargate.nat-b"
  }
}

resource "aws_subnet" "internet" {
  vpc_id            = "${aws_vpc.fargate.id}"
  cidr_block        = "${var.vpc_cidr_first_three}.128/26"
  availability_zone = "${data.aws_region.current.name}b"

  tags {
    Name = "${var.env}.fargate.internet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.fargate.id}"

  tags {
    Name = "${var.env}.fargate"
  }
}

resource "aws_nat_gateway" "nat" {
  subnet_id     = "${aws_subnet.internet.id}"
  allocation_id = "${aws_eip.nat.id}"
  depends_on    = ["aws_internet_gateway.igw"]

  tags {
    Name = "${var.env}.fargate"
  }
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_route_table" "nat" {
  vpc_id = "${aws_vpc.fargate.id}"

  tags {
    Name = "${var.env}.fargate.nat"
  }
}

resource "aws_route_table_association" "nat-c" {
  subnet_id      = "${aws_subnet.nat-c.id}"
  route_table_id = "${aws_route_table.nat.id}"
}

resource "aws_route_table_association" "nat-b" {
  subnet_id      = "${aws_subnet.nat-b.id}"
  route_table_id = "${aws_route_table.nat.id}"
}

resource "aws_route" "nat" {
  route_table_id         = "${aws_route_table.nat.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat.id}"
}

resource "aws_route_table" "internet" {
  vpc_id = "${aws_vpc.fargate.id}"

  tags {
    Name = "${var.env}.fargate.internet"
  }
}

resource "aws_route" "internet" {
  route_table_id         = "${aws_route_table.internet.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.igw.id}"
}

resource "aws_route_table_association" "internet" {
  subnet_id      = "${aws_subnet.internet.id}"
  route_table_id = "${aws_route_table.internet.id}"
}
