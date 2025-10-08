# Cloud Infrastructure Modules

This repository contains modular infrastructure components organized by cloud provider and shared utilities. Each module is self-contained and includes its own `README.md` for detailed documentation and usage instructions.

## Folder Structure

- `aws/`  
  Contains infrastructure components specific to Amazon Web Services (AWS).  
  Examples: EC2 instances, S3 buckets, IAM roles, VPC configurations.

- `azure/`  
  Contains infrastructure components specific to Microsoft Azure.  
  Examples: Resource groups, virtual networks, storage accounts, role assignments.

- `shared/`  
  Contains components that are common across cloud providers or reusable in multiple modules.  
  Examples: Naming conventions, tagging strategies, monitoring configurations, CI/CD templates.

## Usage

Each module is designed to be used independently or composed into larger infrastructure deployments. Refer to the `README.md` inside each folder for setup instructions, input/output variables, and examples.

## Contributing

Feel free to contribute improvements or new modules. Please follow the structure and documentation standards outlined in each module's `README.md`.
