resource "aws_vpc" "main" {
  cidr_block           = "10.10.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name = "hello_vpc"
  }
}

resource "aws_subnet" "main_subnet" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.10.1.0/24"

  # TODO: comment this out once debugging is done
  map_public_ip_on_launch = true

  tags = {
    Name = "hello_subnet"
  }
}

# Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "main"
  }
}

# route tables
resource "aws_route_table" "main-public" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main-gw.id}"
  }

  tags {
    Name = "main-public"
  }
}

# route associations public
resource "aws_route_table_association" "main-public" {
  subnet_id      = "${aws_subnet.main_subnet.id}"
  route_table_id = "${aws_route_table.main-public.id}"
}
