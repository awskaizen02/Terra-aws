Cloud Agnostic Infrastructure : 
➤ Cloud Agnostic means Spread/execute Infrastructure on multiple clouds. 
➤ Flexibility is one of the greatest benefit of Cloud Agnostic Infra. 
➤ Being cloud agnostic means that you’re capable of switching tracks to a different public cloud provider, with minimal disruption to your business. 
➤ Another reason that companies want to embrace this strategy is to avoid vendor lock-in.  
➤ Terraform is cloud-agnostic and allows a single configuration to be used to manage multiple providers, and to even handle cross-cloud dependencies.

 Purpose and Benefits of State : 
➤ State is a necessary requirement for Terraform to function. 
➤ State files are some sort of database to map Terraform config to the real world.  
➤ Alongside the mappings between resources and remote objects, Terraform must also track metadata such as resource dependencies. 
➤ For every plan and apply, Terraform will sync all resources in your state.



Alias: Multiple Provider Configurations 
➤ Multiple configurations can be defined for the same provider. 
➤ Primary reason of alias is to support multiple regions for a cloud platform.
```
# it as the default, and it can be referenced as `aws`. 
provider "aws" { 
region = "us-east-1" 
} 
# reference this as `aws.west`. 
provider "aws" { 
alias  = "west" 
region = "us-west-2" 
}
```
 ➤Handle Terraform and Provider Installation and Versioning : 
➤Selecting Alternate Provider Configurations
```
 resource "aws_instance" "foo" { 
  provider = aws.west 
  # ... 
}

 module "aws_vpc" { 
  source = "./aws_vpc" 
  providers = { 
    aws = aws.west 
  } 
}
```

➤ Describe plug-in based architecture : 
➤ Terraform uses a plugin-based architecture to support hundreds of infrastructure and service providers.  

➤ Initializing a configuration directory downloads and installs providers used in the configuration. 
terraform init 

➤ Format your configuration. 
terraform fmt  

➤ Validate your configuration. 
terraform validate 


➤ Provisioners can be used to event specific actions in order to prepare servers for service. 
➤ Passing data into virtual machines. Terraform have multiple Provisioners to pass data to public Cloud. 
➤ user_data : AWS, Alibaba Cloud 
➤ metadata : Google Cloud Platform 
➤ custom_data : Microsoft Azure

 
➤ local-exec provisioner is used to run the CLI for your target system in order to create, update, or interact with remote objects in that system. 
➤ If you are trying to use a new feature of the remote system that isn't yet upported in its Terraform provider, local-exec might be the only option.

```
 resource "aws_instance" “server" { 
# ... 
provisioner "local-exec" { 
command = "echo The server's IP address is ${self.private_ip}" 
  } 
}
```

➤ Expressions in provisioner blocks cannot refer to their parent resource by name. Instead, they can use the special self object.  
➤ All log output from the provisioner is automatically suppressed to prevent the sensitive values from being displayed.

➤ remote-exec provisioner invokes a script on a remote resource after it is created.  
➤ inline - This is a list of command strings. They are executed in the order they are provided.  
➤ script - This is a path to a local script that will be copied to the remote resource and then executed.  
➤ scripts - This is a list of paths to local scripts that will be copied to the remote resource and then executed. They are executed in the order they are provided.

 
➤How to execute Script with Arguments?  
➤User cannot pass any arguments to scripts using the script or scripts arguments to this provisioner. If you want to specify arguments, upload the script with the file provisioner and then use inline to call it.

```
 resource "aws_instance" "server" { 
  provisioner "file" { 
    source      = “test_script.sh" 
    destination = "/tmp/test_script.sh" 
  } 
  provisioner "remote-exec" { 
    inline = [ 
      "chmod +x /tmp/test_script.sh", 
      "/tmp/test_script.sh args", 
    ] 
  }
``` 
 ➤ Creation-Time Provisioners : 
➤ By Default, provisioner run after the resource creation.  
➤ Creation-time provisioners are only run during creation, not during updating or any other lifecycle. 
➤ Creation-time provisioner fails, the resource is marked as tainted. A tainted resource will be planned for destruction and recreation upon the next terraform apply. 

 ➤ Provisioners Failure Behaviour : 
➤ By default, provisioners that fail will also cause the Terraform apply itself to  fail. The on_failure setting can be used to change this.  
➤ continue - Ignore the error and continue with creation or destruction. 
➤ fail - Raise an error and stop applying. If this is a creation provisioner, taint  the resource.
```
resource "aws_instance" "server" { 
provisioner "local-exec" { 
command    = "echo The server's IP address is ${self.private_ip}" 
on_failure = continue 
  } 
}
```

Use terraform fmt : 
➤ terraform fmt command is used to rewrite Terraform configuration files to a canonical format and style. 
➤ Use terraform taint : 
➤ The terraform taint command manually marks a Terraform managed resource as tainted, forcing it to be destroyed and recreated on the next apply.  
➤ This command will not modify infrastructure, but does modify the state file in order to mark a resource as tainted. 
➤ Usage: terraform taint address

➤ Use terraform import : 
➤ terraform import command is used to import existing resources into Terraform.  
``` 
terraform import aws_instance.test_ins i-1234
```
➤ Terraform Workspace : 
➤ Terraform persistent data stored in backend which belongs to Workspace. 
➤ Initially Backend have only one workspace “default”. 
➤ Create New WorkSpace.
``` 
terraform workspace new test 
Created and switched to workspace “test"!
```
 ➤ Named workspaces allow conveniently switching between multiple instances of a single configuration.  
➤ A common use for multiple workspaces is to create a parallel, distinct copy of a set of infrastructure in order to test a set of changes before modifying the main production infrastructure.

 ➤ Debugging Terraform : 
➤ Terraform has detailed logs which can be enabled by setting the TF_LOG environment variable to any value. 
➤ User can set TF_LOG to one of the log levels TRACE, DEBUG, INFO, WARN or ERROR to change the verbosity of the logs.  
➤ TRACE is the most verbose and it is the default if TF_LOG is set to something other than a log level name.  
➤ To persist logged output you can set TF_LOG_PATH in order to force the log to always be appended to a specific file when logging is enabled.

 ➤ Set Terraform Logs: 
➤ export TF_LOG=TRACE 
➤ To disable, either unset it or set it to empty. 
➤ export TF_LOG= 
➤ Set TF log path - 
➤ export TF_LOG_PATH=./terraform.log


➤ Contrast Module Source Options 
➤ Interact with Module Inputs and Outputs 
➤ Describe Variable Scope within Modules  
➤ Discover Modules from the Public Terraform Module Registry  
➤ Defining module version

➤ Contrast Module Source Options : 
➤ Modules are used to Organise Configuration in Terraform. 
➤ Modules make it easier to navigate, understand, and update your configuration by keeping related parts of your configuration together.  
➤ Another benefit of using modules is to encapsulate configuration into distinct logical components. 
➤ Code reusability is the Sole feature of modules in Terraform.

➤ Interact with Module Inputs and Outputs : 
➤ Pattern to define Input variable for module is similar to define input for   terraform configuration file. 
```
variable "vpc_name" { 
description = "Name of VPC" 
type        = string 
default     = "example-vpc" 
}
```

➤ Modules also have output values, which are defined within the module with the output keyword.  
➤ User can access them by referring to module.<MODULE NAME>.<OUTPUT NAME>.
```
output "vpc_public_subnets" { 
description = "IDs of the VPC's public subnets" 
value       
= module.vpc.public_subnets 
}
```
➤ Describe Variable Scope within Modules : 
➤ Input variables serve as parameters for a Terraform module, allowing aspects of the module to be customized without altering the module's own source code, and allowing modules to be shared between different configurations. 
➤ Root Module - Every Terraform configuration has at least one module, known as its root module. 
➤ Child Module - A Terraform module can call other modules to include their resources into the configuration. A module that has been called by another module is often referred to as a child module


➤ Terraform workflow have 3 Steps: 
➤ Write  
➤ Plan 
➤ Apply 

➤ Write - Write Terraform configuration just like you write code. 
➤ Plan - Preview changes before applying. 
➤ Apply - Provision reproducible infrastructure.

➤ Initialize a Terraform working directory : 
➤ terraform init command is used to initialize a working directory containing Terraform configuration files. 
➤ This is the first command that should be run after writing a new Terraform configuration or cloning an existing configuration. 
➤ Terraform init initialize the backend. 
➤ Initialisation search for modules in configuration files, and install child modules. 
➤ Download the Plugins.

➤ Validate a Terraform configuration : 
➤ terraform validate command validates the configuration files in a directory.  
➤ Validate runs checks that verify whether a configuration is syntactically valid and internally consistent.  
➤ terraform validate -json : Produce output in a machine readable JSON format.

➤ Generate and Review an execution plan for Terraform : 
➤ terraform plan command is used to create an execution plan. 
➤ This command is a convenient way to check whether the execution plan for a set of changes matches your expectations without making any changes to real resources or to the state.  
➤ The optional -out argument can be used to save the generated plan to a file for later execution with terraform apply.

 ➤ Execute changes to infrastructure with Terraform : 
➤ terraform apply command is used to apply the changes required to reach the desired state of the configuration, or the pre-determined set of actions generated by a terraform plan execution plan.

 ➤ Destroy Terraform managed Infrastructure : 
➤ The terraform destroy command is used to destroy the 
Terraform-managed infrastructure. 
➤ terraform destroy -auto-approve :  Destroy confirmation will not be shown. 

Describe default local backend : 
➤ “Backend” in Terraform determines how state is loaded and how an operation such as apply is executed. 
➤ By default, Terraform uses the "local" backend. 
➤ Backends can store their state remotely and protect that state with locks to prevent corruption. 
➤ State is retrieved from backends on demand and only stored in memory. 
➤ User can successfully use Terraform without ever having to learn or use backends.

 ➤ Outline state locking : 
➤ State locking happens automatically on all operations that 
could write state. 
➤ User can disable state locking for most commands with the -lock flag. 
➤ User can execute force unlock to unlock the state.

 ➤ Describe effect of Terraform Refresh on State : 
➤ Terraform refresh is used to refresh the Terraform State files. 
➤ This does not modify infrastructure, but does modify the state file. 

 ➤ Sensitive Data in State : 
➤ Terraform state can contain sensitive data, depending on the resources in use. 
➤ State in local machine, stored in plain-text JSON files.  
➤ Storing state remotely can provide better security


Collection type allows multiple values of one other type to be grouped together as a single value. 

➤ Terraform have 3 Collection Types- 
➤ list() - A sequence of values. 
➤ map() - A collection of key-value pair. 
➤ set() - A collection of unique values

➤ Understand the use of Collection and Structural types : 
➤ Structural Type allows multiple values of several distinct types to be grouped 
together as a single value. 
➤ Terraform have 2 Structural Types- 
➤ object() - A pair of curly braces containing a comma-separated series of 
<KEY> = <TYPE> pairs. 
{ 
 name = "John" 
 age  = 52 
}
➤ tuple() - A pair of square brackets containing a comma-separated series of 
types. 
["a", 15, true]
