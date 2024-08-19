output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.demo.id
}

output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = aws_subnet.demo[*].id
}

output "subnet_cidr_blocks" {
  description = "The CIDR blocks of the subnets"
  value       = aws_subnet.demo[*].cidr_block
}

/*
In Terraform, an "output attribute" (commonly referred to simply as "output") is used to display information about your infrastructure after a terraform apply command. Outputs can be useful for extracting information from your configurations that can be used in other parts of your infrastructure or displayed for reference.

How to Use Outputs:
From the Command Line: When you run terraform apply or terraform output, Terraform will display the output values.
As Input to Other Configurations: Outputs from one configuration can be used as input variables in another configuration.
Programmatic Access: You can programmatically access these outputs, such as when integrating Terraform with other automation tools or scripts.
*/