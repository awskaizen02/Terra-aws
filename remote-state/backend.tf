terraform {
    backend "s3" {
        bucket = "aws-may-23-demo-bucket"
        key    = "test/terraform_state"
        region = "ap-south-1"
    }
}

/*
"remote state" refers to the practice of storing the Terraform state file in a remote backend instead of locally on the machine where Terraform is run. The state file is a crucial part of Terraform's operation because it keeps track of the resources it manages, mapping them to the configuration files. Using remote state enables collaboration, enhances security, and provides better state management for teams working on infrastructure.

Benefits of Remote State:
Collaboration: Multiple team members can access and modify the state file concurrently.

Security: State files can contain sensitive information. Storing them in a remote backend allows for better access control and encryption.

Locking: Some remote backends support state locking, preventing concurrent operations that could lead to conflicts or corrupt states.

Backups: Many remote backends automatically manage state file versions, providing a history and backups of state changes.

Common Remote Backends:
Amazon S3: Often used with DynamoDB for state locking and consistency checking.
Azure Blob Storage: Used in conjunction with Azure’s storage services.
Google Cloud Storage (GCS): Used within Google Cloud Platform environments.
Terraform Cloud/Enterprise: Provides enhanced features such as workspace management, VCS integration, and more.
Consul: Can be used for state storage and also supports state locking.
*/