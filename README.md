# Terraform module for NAT intance

This modules deploys and configures a NAT instance on a public subnet of an AWS VPC. It also modifies the route table associated with the private subnets of the VPC to forward all Internet traffic to the NAT instance. That way EC2 instances deployed on private subnets will be able to download packages and updates from the Internet.

## Module input parameters

| Parameter                   | Type     | Description                                                                           |
| --------------------------- |--------- | ------------------------------------------------------------------------------------- |
| vpc_id                      | Required | The id of the VPC at which the NAT instance will be installed                         |
| vpc_private_subnet_cidrs    | Required | A list of all private subnets cidrs within the vcp                                    |
| vpc_private_route_table_id  | Required | The id of the route table associated with the private subnets of the VPC              |
| nat_instance_key_path       | Required | The path to the file containing the public ssh key to be installed on the NAT instance for connecting via ssh |
| nat_instance_type           | Required | The instance type of the NAT instance                                                 |
| nat_instance_subnet_id      | Required | The id of the public subnet on which the NAT instance will be deployed                |
| ssh_allowed_security_groups | Optional | A list of security groups that will be allowed to connect to the NAT instance via ssh |
| ssh_allowed_cidr_blocks     | Optional | A list of CIDR blocks that will be allowed to connect to the NAT instance via ssh     |

## Module output parameters

| Parameter              | Description                                                   |
| ---------------------- | ------------------------------------------------------------- |
| openvpn_server_dns     | The id of the security group associated with the NAT instance |