data "aws_ami" "nat_instance_ami" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*"]
  }
}

resource "aws_key_pair" "nat_instance_key" {
  key_name   = var.nat_instance_key_name
  public_key = file(var.nat_instance_key_path)
}

resource "aws_security_group" "nat_instance_sg" {
  name        = local.nat_instance_sg["name"]
  description = "The security group of the NAT instance."
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = local.nat_instance_sg["ingress"]
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = local.nat_instance_sg["egress"]
    content {
      from_port   = egress.value.from
      to_port     = egress.value.to
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}

resource "aws_instance" "nat_instance" {
  ami                         = data.aws_ami.nat_instance_ami.id
  instance_type               = var.nat_instance_type
  vpc_security_group_ids      = [aws_security_group.nat_instance_sg.id]
  associate_public_ip_address = true
  subnet_id                   = var.nat_instance_subnet_id
  key_name                    = aws_key_pair.nat_instance_key.key_name
  source_dest_check           = false
  user_data                   = file("${path.module}/scripts/init_nat_instance.sh")

  tags = {
    Name = "NAT-instance"
  }
}

resource "aws_route" "nat_instance_route" {
  route_table_id = var.vpc_private_route_table_id

  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_instance.nat_instance.primary_network_interface_id
}