provider "aws" {
  region = "us-west-2"  # Change this to your desired region
}

module "vpc" {
  source             = "../modules/vpc"
  vpc_cidr           = "10.1.0.0/16"
  vpc_name           = "prod_vpc"
  public_subnet_cidr = "10.1.1.0/24"
  private_subnet_cidr = "10.1.2.0/24"
}

module "ec2" {
  source         = "../modules/ec2"
  vpc_id         = module.vpc.vpc_id
  subnet_id      = module.vpc.public_subnet_id
  ami            = "ami-0c55b159cbfafe1f0"  # Example AMI ID (Amazon Linux 2)
  instance_type  = "t2.micro"
  ec2_name       = "prod_ec2_instance"
}

# Outputs for verification
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  value = module.vpc.private_sub
}