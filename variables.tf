variable "vpc_id" {
  description = "The id of the VPC at which the NAT instance will be installed."
}

variable "vpc_private_subnet_cidrs" {
  description = "A list of all private subnets cidrs within the vcp."
}

variable "vpc_private_route_table_id" {
  description = "The id of the route table associated with the VPC private subnets."
}

variable "nat_instance_subnet_id" {
  description = "The id of the public subnet on which the NAT instance will be deployed."
}

variable "nat_instance_key_name" {
  description = "The name of the ssh key of the NAT instance."
}

variable "nat_instance_key_path" {
  description = "The path to the file containing the public ssh for the NAT instance."
}

variable "nat_instance_type" {
  description = "The instance type of the NAT instance."
}