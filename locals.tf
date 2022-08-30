locals {
  nat_instance_sg = {
    name        = "nat-instance-sg"
    description = "Security Group for the nat instance"
    ingress = {
      http = {
        from        = 80
        to          = 80
        protocol    = "tcp"
        cidr_blocks = var.vpc_private_subnet_cidrs
      }
      https = {
        from        = 443
        to          = 443
        protocol    = "tcp"
        cidr_blocks = var.vpc_private_subnet_cidrs
      }
    }
    egress = {
      http = {
        from        = 80
        to          = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
      https = {
        from        = 443
        to          = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
    optional_ingress = {
      ssh = {
        from            = 22
        to              = 22
        protocol        = "tcp"
        security_groups = var.ssh_allowed_security_groups
        cidr_blocks     = var.ssh_allowed_cidr_blocks
      }
    }
  }
}