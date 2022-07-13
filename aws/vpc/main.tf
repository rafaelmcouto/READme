data "aws_availability_zones" "azs" {}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false

  tags = var.is_eks_enabled ? "${
    merge(
      var.tags_shared,
      tomap({
        "Name"                                  = "${var.vpc_name}",
        "kubernetes.io/cluster/${var.eks_name}" = "shared"
      })
    )
    }" : "${
    merge(
      var.tags_shared,
      tomap({
        "Name" = "${var.vpc_name}"
      })
    )
  }"
}

############################################################################################
#                             Subnet PUB Configuration                                     #
############################################################################################
resource "aws_subnet" "pub" {
  count                   = length(var.pub_subnets_cidr_block)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.pub_subnets_cidr_block, count.index)
  availability_zone       = element(data.aws_availability_zones.azs.names, count.index)
  map_public_ip_on_launch = true

  tags = var.is_eks_enabled ? merge(
    var.tags_shared,
    tomap({
      "Name"                                  = "${var.vpc_name}-pub-${element(data.aws_availability_zones.azs.names, count.index)}",
      "kubernetes.io/cluster/${var.eks_name}" = "shared"
    })
    ) : merge(
    var.tags_shared,
    tomap({
      "Name" = "${var.vpc_name}-pub-${element(data.aws_availability_zones.azs.names, count.index)}",
    })
  )
}

resource "aws_route_table" "pub-route-table" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.tags_shared,
    tomap({
      "Name" = "${var.vpc_name}-pub-rt"
    })
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.tags_shared,
    tomap({
      "Name" = "${var.vpc_name}-igw",
    })
  )
}

resource "aws_route" "pub-route" {
  route_table_id         = aws_route_table.pub-route-table.id
  destination_cidr_block = var.all_allowed_output_ips
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "pub-association" {
  count          = length(var.pub_subnets_cidr_block)
  subnet_id      = element(aws_subnet.pub.*.id, count.index)
  route_table_id = aws_route_table.pub-route-table.id
}

resource "aws_eip" "nat-ips" {
  vpc = true
  tags = merge(
    var.tags_shared,
    tomap({
      "Name" = "${var.vpc_name}-nat-eip"
    })
  )
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat-ips.id
  subnet_id     = aws_subnet.pub.0.id
  depends_on    = [aws_internet_gateway.igw]

  tags = merge(
    var.tags_shared,
    tomap({
      "Name" = "${var.vpc_name}-nat-gw"
    })
  )
}

############################################################################################
#                             Subnet APP Configuration                                     #
############################################################################################
resource "aws_subnet" "app" {
  count                   = length(var.app_subnets_cidr_block)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.app_subnets_cidr_block, count.index)
  availability_zone       = element(data.aws_availability_zones.azs.names, count.index)
  map_public_ip_on_launch = false

  tags = merge(
    var.tags_shared,
    tomap({
      "Name" = "${var.vpc_name}-app-${element(data.aws_availability_zones.azs.names, count.index)}"
    })
  )
}

resource "aws_route_table" "app-route-table" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.tags_shared,
    tomap({
      "Name" = "${var.vpc_name}-app-rt"
    })
  )
}

resource "aws_route" "app-route" {
  route_table_id         = aws_route_table.app-route-table.id
  destination_cidr_block = var.all_allowed_output_ips
  nat_gateway_id         = aws_nat_gateway.nat-gw.id
}

resource "aws_route_table_association" "app-association" {
  count          = length(var.app_subnets_cidr_block)
  subnet_id      = element(aws_subnet.app.*.id, count.index)
  route_table_id = aws_route_table.app-route-table.id
}


############################################################################################
#                             Subnet DATA Configuration                                    #
############################################################################################
resource "aws_subnet" "data" {
  count                   = length(var.data_subnets_cidr_block)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.data_subnets_cidr_block, count.index)
  availability_zone       = element(data.aws_availability_zones.azs.names, count.index)
  map_public_ip_on_launch = false

  tags = merge(
    var.tags_shared,
    tomap({
      "Name" = "${var.vpc_name}-data-${element(data.aws_availability_zones.azs.names, count.index)}"
    })
  )
}

resource "aws_route_table" "data-route-table" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.tags_shared,
    tomap({
      "Name" = "${var.vpc_name}-data-rt"
    })
  )
}

resource "aws_route" "data-route" {
  route_table_id         = aws_route_table.data-route-table.id
  destination_cidr_block = var.all_allowed_output_ips
  nat_gateway_id         = aws_nat_gateway.nat-gw.id
}

resource "aws_route_table_association" "data-association" {
  count          = length(var.data_subnets_cidr_block)
  subnet_id      = element(aws_subnet.data.*.id, count.index)
  route_table_id = aws_route_table.data-route-table.id
}
