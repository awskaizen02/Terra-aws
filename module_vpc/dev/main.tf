provider "aws" {
  region = "ap-south-1"  # Change this to your desired region
}

module "vpc" {
  source             = "../modules/vpc"
  vpc_cidr           = "10.0.0.0/16"
  vpc_name           = "dev_vpc"
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
}

# Outputs for verification
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}
