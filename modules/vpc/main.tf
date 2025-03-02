data "aws_vpc" "name-vpc" {
  default = true
  id = var.vpc_id
}

data "aws_internet_gateway" "igw-1" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.name-vpc.id]
  }
}

locals {
  subnet_name = "${terraform.workspace}"
}

resource "aws_subnet" "sub-all" {
  for_each                = var.subnet_config
  vpc_id                  = data.aws_vpc.name-vpc.id
  cidr_block              = cidrsubnet(data.aws_vpc.name-vpc.cidr_block, each.value.new_bits, each.value.netnum)
  availability_zone       = each.value.az
  map_public_ip_on_launch = each.value.type == "public" ? true : false

  tags = {
    name = "${local.subnet_name}-${each.key}-subnet"
  }
}

resource "aws_route_table" "rt-pub" {
  vpc_id = data.aws_vpc.name-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.igw-1.id
  }
}


resource "aws_eip" "eip-1" {
  domain = "vpc"

  tags = {
    "name" = "eip-2-tier"
  }
}

resource "aws_nat_gateway" "tg-1" {
  allocation_id = aws_eip.eip-1.id
  subnet_id       = aws_subnet.sub-all["public-sub-1"].id 

  tags = {
    name = "tg-2-tier"
  }



}

resource "aws_route_table_association" "pub-rt-attch-1" {
  route_table_id = aws_route_table.rt-pub.id
  subnet_id      = aws_subnet.sub-all["public-sub-1"].id

}
resource "aws_route_table_association" "pub-rt-attch-2" {
  route_table_id = aws_route_table.rt-pub.id
  subnet_id      = aws_subnet.sub-all["public-sub-2"].id

}

resource "aws_route_table" "pvt-rt" {
  vpc_id = data.aws_vpc.name-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.tg-1.id
  }
}

resource "aws_route_table_association" "pvt-rt-attch-1" {
  route_table_id = aws_route_table.pvt-rt.id
  subnet_id      = aws_subnet.sub-all["private-sub-1"].id

}
resource "aws_route_table_association" "pvt-rt-attch-2" {
  route_table_id = aws_route_table.pvt-rt.id
  subnet_id      = aws_subnet.sub-all["private-sub-2"].id

}
