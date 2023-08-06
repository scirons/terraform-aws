variable "aws_region" {
  type        = string
  description = "AWS region."
  default     = "us-east-1"
}

variable "instance_ami" {
  type        = string
  description = "AMI (Amazon Machine Image) that identifies the instance"
  default     = "ami-053b0d53c279acc90"
}

variable "instance_type" {
  type        = string
  description = "Instance type to be used."
  default     = "t2.micro"
}

variable "instance_key_name" {
  type        = string
  description = "The name of the SSH key to associate to the instance"
  default     = ""
}

variable "instance_availzone" {
  type        = string
  description = "The data centers zone within a region"
  default     = "us-east-1a"
}

variable "instance_associate_public_ip" {
  type        = string
  description = "Defines if the EC2 instance has a public IP address."
  default     = "true"
}

variable "instance_tag_name" {
  type        = string
  description = "instance_tag_name"
  default     = "ec2-terraform-basic"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block to associate to the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  type        = string
  description = "CIDR block to associate to the subnet"
  default     = "10.0.1.0/24"
}

variable "vpc_tag_name" {
  type        = string
  description = "Assign name to vpc"
  default     = "ec2-vpc-terra"
}

variable "ig_tag_name" {
  type        = string
  description = "Assign name to the Internet Gateway"
  default     = "ec2-gateway-terra"
}

variable "subnet_tag_name" {
  type        = string
  description = "Assign name to subnet"
  default     = "ec2-subnet-terra"
}

variable "sg_tag_name" {
  type        = string
  description = "Assign name to the security group"
  default     = "ec2-sg-terra"
}
