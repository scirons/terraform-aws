# Terraform for AWS EC2 instances

Automatic deployment and management of EC2 instances using Terraform.

<img align="right" width="100" height="100" src="https://avatars.githubusercontent.com/u/31414033?s=200&v=4">

<hr/>


* This is a Terraform module that constructs, deploys and manages EC2 instances.
* Any application that requires a dedicated server can make use of this module.
* As of now, the module creates a single EC2 instance.
* The instance type and dimensions are configurable.
* Support for Lambda/Functions and complex container-based templates are being implemented.

<hr/>

## Implementation details

The stack created by this terraform module is composed of:
  * Compute
    * EC2 instance
  * Network
    * Virtual Private Cloud
    * Internet Gateway
    * Security Group
    * Route table
    * Subnet


<hr/>

## Input/Output

### Input

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws_region | The AWS region | string | `aws-region` | yes |
| ig_tag_name | Assign name to the Internet Gateway | string | `ec2-gateway-terra` | no |
| instance_ami | AMI (Amazon Machine Image) that identifies the instance | string | `ami-053b0d53c279acc90` | no |
| instance_associate_public_ip | Defines if the EC2 instance has a public IP address. | string | `true` | no |
| instance_key_name | The name of the SSH key to associate to the instance. Note that the key must exist already. | string | `engagement-key` | no |
| instance_tag_name | instance_tag_name | string | `ec2-terraform-basic` | no |
| instance_type | Instance type to be used | string | `t2.micro` | no |
| sg_tag_name | The Name to apply to the security group | string | `ec2-sg-terra` | no |
| subnet_cidr_block | CIDR block to associate to the subnet | string | `10.0.1.0/24` | no |
| subnet_tag_name | The Name to apply to the VPN | string | `ec2-subnet-terra` | no |
| vpc_cidr_block | CIDR block to associate to the VPC | string | `10.0.0.0/16` | no |
| vpc_tag_name | Assign name to the VPC | string | `ec2-vpc-terra` | no |

### Outputs

| Name | Description |
|------|-------------|
| instance_id | The EC2 instance ID |
| server_public_ip | The EC2 instance public IPv4 |

<hr/>

## Todos

- [ ] IPv6 Implementation
- [ ] Docker Templates
- [ ] Support Lambda/Functions
- [ ] Improve documentation

<hr/>

## Resources

* Terraform resource [aws_instance](https://www.terraform.io/docs/providers/aws/r/instance.html)
* Terraform [VPC](https://www.terraform.io/docs/providers/aws/r/vpc.html)
* Terraform [subnet](https://www.terraform.io/docs/providers/aws/r/subnet.html)
* AWS explains [VPCs and subnets](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html)
* AWS explains [internet gateway](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html)
* Terraform [security groups](https://www.terraform.io/docs/providers/aws/r/security_group.html)
* Terraform [route table](https://www.terraform.io/docs/providers/aws/r/route_table.html)
* Good resource explaining teraform vpc and subnet creation [here](https://hackernoon.com/manage-aws-vpc-as-infrastructure-as-code-with-terraform-55f2bdb3de2a)

<hr/>
