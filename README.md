# Terraform module for NAT intance

This modules deploys and configures a NAT instance on a public subnet of an AWS VPC. It also modifies the route table associated the private subnets of the VPC to forward all Internet traffic to the NAT instance. That way EC2 instances deployed on private subnets will be able to download packages and updates from the Internet.

## Module input parameters

| Parameter                  | Description                                                              |
| -------------------------- | ------------------------------------------------------------------------ |
| vpc_id                     | The id of the VPC at which the NAT instance will be installed            |
| vpc_private_subnet_cidrs   | A list of all private subnets cidrs within the vcp                       |
| vpc_private_route_table_id | The id of the route table associated with the private subnets of the VPC |
| nat_instance_key_name      | The name of the ssh key of the NAT instance                              |
| nat_instance_key_path      | The path to the file containing the public ssh key for the NAT instance  |
| nat_instance_type          | The instance type of the NAT instance                                    |
| nat_instance_subnet_id     | The id of the public subnet on which the NAT instance will be deployed   |

## Module output parameters

| Parameter              | Description                                                   |
| ---------------------- | ------------------------------------------------------------- |
| openvpn_server_dns     | The id of the security group associated with the NAT instance |