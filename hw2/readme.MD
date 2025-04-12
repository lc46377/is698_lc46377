# Terraform AWS Infrastructure Deployment

This Terraform project automates the deployment of an AWS infrastructure environment for our assignment. The environment includes the following components:

- **VPC** with Public and Private Subnets  
- **NAT Gateway** in a public subnet for outbound connectivity from private subnets  
- **EC2 Instance** running a web server (Apache) in a private subnet  
- **S3 Bucket** for static web file storage  
- **DynamoDB Table** for storing user login details  
- *(Optional)* **Application Load Balancer (ALB)** to route traffic to the web server

## Directory Structure

terraform/ ├── main.tf # Root configuration that calls all modules ├── variables.tf # Global variables (optional) ├── outputs.tf # Global outputs (optional) └── modules/ ├── vpc/ │ ├── main.tf │ ├── variables.tf │ └── outputs.tf ├── ec2/ │ ├── main.tf │ ├── variables.tf │ └── outputs.tf ├── s3/ │ ├── main.tf │ ├── variables.tf │ └── outputs.tf ├── dynamodb/ │ ├── main.tf │ ├── variables.tf │ └── outputs.tf └── alb/ # (Optional) ALB module for automation of the Application Load Balancer ├── main.tf ├── variables.tf └── outputs.tf

markdown
Copy

## Prerequisites

Before you begin, ensure you have:

- [Terraform](https://www.terraform.io/downloads.html) installed (version 1.x recommended)
- AWS credentials configured (via environment variables, shared credentials file, or an IAM role)
- An AWS account with permissions to create VPCs, subnets, EC2, S3, DynamoDB, NAT Gateways, etc.

## How to Use

### 1. Initialization

Navigate to the root Terraform directory and initialize the project:

```bash
terraform init
This command downloads the required provider plugins and sets up your project.

2. Plan the Deployment
Review the execution plan to see which resources will be created, modified, or destroyed:

bash
Copy
terraform plan
3. Apply the Configuration
Deploy the infrastructure by running:

bash
Copy
terraform apply
Confirm the prompt by typing yes. Terraform will then provision the resources as defined.

4. Verify the Deployment
AWS Console: Log into the AWS Console and verify that the VPC, subnets, NAT Gateway, EC2 instance, S3 bucket, and DynamoDB table have been created.

EC2 Instance: If applicable, verify that your EC2 instance in the private subnet is running the web server (e.g., via ALB or connecting through a bastion host).

Outputs: Refer to Terraform’s output for resource IDs, instance private IPs, and other important information.

5. Clean Up
To remove all resources created by this configuration, run:

bash
Copy
terraform destroy
Confirm with yes when prompted. This command tears down the entire infrastructure to prevent unwanted charges.

Variables and Customization
VPC Module:
Variables like vpc_cidr, vpc_name, public_subnet_cidrs, private_subnet_cidrs, etc. are defined in modules/vpc/variables.tf. You can override these in the root module (main.tf) if needed.

EC2 Module:
Variables for ami_id, instance_type, key_name, and private_subnet_id are configured in modules/ec2/variables.tf. Make sure to set a valid Amazon Linux 2 AMI ID for your region.

S3 Module:
The S3 bucket name must be globally unique. Configure this in the S3 module variables.

DynamoDB Module:
Table name and provisioned capacities are configurable.