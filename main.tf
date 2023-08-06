# Define provider
provider "aws" {
  region                   = var.aws_region
#  shared_credentials_files = ["./aws-creds"] # For local stored credentials
}

# Deploy instance
resource "aws_instance" "instance" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  key_name                    = var.instance_key_name
  availability_zone           = var.instance_availzone
  disable_api_termination     = true
  associate_public_ip_address = var.instance_associate_public_ip
  vpc_security_group_ids      = ["${aws_security_group.sg.id}"]
  subnet_id                   = aws_subnet.subnet.id


  tags = {
    Name = var.instance_tag_name
  }
}

# Create vpc
resource "aws_vpc" "vpc" {
  cidr_block         = var.vpc_cidr_block
  enable_dns_support = true
  # assign_generated_ipv6_cidr_block = true

  tags = {
    Name = var.vpc_tag_name
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.ig_tag_name
  }
}

# Create a subnet
resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 4, 1)
  availability_zone = var.instance_availzone

  #  ipv6_cidr_block         = cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 8, 10)
  #  assign_ipv6_address_on_creation = true

  tags = {
    Name = var.subnet_tag_name
  }
}

# Create custom Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  #  route {
  #    ipv6_cidr_block = "::/0"
  #    gateway_id      = aws_internet_gateway.gw.id
  #  }
}

# Associate subnet with Route Table
resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.rt.id
}

# Create Security Group to allow ports
resource "aws_security_group" "sg" {
  name        = var.sg_tag_name
  description = "Allow web/email inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Allow ssh"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP/1"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP/2"
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP/3"
    from_port   = "443"
    to_port     = "443"
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SMTP"
    protocol    = "tcp"
    from_port   = "25"
    to_port     = "25"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SMTP"
    protocol    = "tcp"
    from_port   = "465"
    to_port     = "465"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow IMAPS"
    protocol    = "tcp"
    from_port   = "993"
    to_port     = "993"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Default Mail Submission"
    protocol    = "tcp"
    from_port   = "587"
    to_port     = "587"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow ping for all"
    protocol    = "icmp"
    from_port   = "8"
    to_port     = "0"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol         = "-1"
    from_port        = "0"
    to_port          = "0"
    ipv6_cidr_blocks = ["::/0"]
  }


  egress {
    protocol    = "-1"
    from_port   = "0"
    to_port     = "0"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol         = "-1"
    from_port        = "0"
    to_port          = "0"
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.sg_tag_name
  }
}
