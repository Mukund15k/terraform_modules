# 🌐 Terraform AWS VPC Module

This module provisions a **production-ready Virtual Private Cloud (VPC)** in AWS using Terraform. It supports the creation of public and private subnets across multiple Availability Zones (AZs), complete with Internet Gateway (IGW), NAT Gateway (NGW), and appropriate route table configurations.

The module is designed to be reusable, scalable, and follows **industry best practices** for security, performance, and manageability.



## ✨ Features

- 🚀 Custom CIDR block for the VPC
- 🌐 Public and private subnets across multiple Availability Zones
- 🌉 Internet Gateway for public subnets
- 🌍 NAT Gateway for secure outbound traffic from private subnets
- 📍 Dedicated route tables for public and private subnets
- 🏷️ Tagging support for all major resources
- 🔁 Easily reusable across environments (`dev`, `stage`, `prod`)
- 🔒 Modular structure for CI/CD deployments

---

## 📐 Architecture Diagram

            ┌───────────────────────────────────────────────┐
            │                  AWS VPC                      │
            │                  10.0.0.0/16                  │
            │                                               │
            │ ┌─────────────┐     ┌──────────────┐          │
            │ │ Public Sub1 │     │ Public Sub2  │          │
            │ │ 10.0.1.0/24 │     │ 10.0.2.0/24  │          │
            │ └──────┬──────┘     └──────┬───────┘          │
            │        │ IGW               │ IGW              │
            │        ▼                   ▼                   │
            │    ┌────────┐        ┌────────┐               │
            │    │ Route  │        │ Route  │               │
            │    │ Table  │        │ Table  │               │
            │    └────────┘        └────────┘               │
            │                                               │
            │ ┌─────────────┐     ┌──────────────┐          │
            │ │ Private Sub1│     │ Private Sub2 │          │
            │ │10.0.101.0/24│     │10.0.102.0/24 │          │
            │ └──────┬──────┘     └──────┬───────┘          │
            │        │ NAT               │ NAT              │
            │        ▼                   ▼                   │
            │    ┌────────┐        ┌────────┐               │
            │    │ Route  │        │ Route  │               │
            │    │ Table  │        │ Table  │               │
            │    └────────┘        └────────┘               │
            └───────────────────────────────────────────────┘


---

## 🚀 Usage Example

```hcl
module "vpc" {
  source = "../vpc"  # or use GitHub path

  name_prefix          = "mkx"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
}


## 📥 Input Variables

| Name                   | Type          | Description                                            | Example                        |
|------------------------|---------------|--------------------------------------------------------|--------------------------------|
| `name_prefix`          | `string`      | Prefix for resource naming                             | `"mkx"`                        |
| `vpc_cidr`             | `string`      | CIDR block for the VPC                                 | `"10.0.0.0/16"`                |
| `public_subnet_cidrs`  | `list(string)`| List of public subnet CIDRs                            | `["10.0.1.0/24", "10.0.2.0/24"]` |
| `private_subnet_cidrs` | `list(string)`| List of private subnet CIDRs                           | `["10.0.101.0/24", "10.0.102.0/24"]` |
| `availability_zones`   | `list(string)`| List of AWS Availability Zones for subnet deployment   | `["us-east-1a", "us-east-1b"]` |


📤 Outputs


| Name                | Description                                    |
|---------------------|------------------------------------------------|
| `vpc_id`            | ID of the VPC                                  |
| `public_subnet_ids` | List of public subnet IDs                      |
| `private_subnet_ids`| List of private subnet IDs                     |
| `nat_gateway_id`    | NAT Gateway ID used for private subnet routing |



🧩 Requirements


Terraform >= 1.2.0

AWS CLI configured with credentials

Terraform AWS provider >= 4.0


🗂️ Folder Structure

vpc/
├── main.tf         # Core logic: VPC, subnets, routes, gateways
├── variables.tf    # All input variables
├── outputs.tf      # Output definitions
└── README.md       # This documentation file


🧪 Testing Strategy


We recommend the following tools:

terraform validate – Basic validation

terraform fmt – Style formatting

tflint – Terraform linter

checkov – Security scan

terratest – Go-based infrastructure testing (optional)



🧠 Best Practices


Use S3 + DynamoDB for remote state backend

Tag all resources with environment (dev, stage, prod)

Run terraform plan in CI before applying

Use depends_on in modules to control resource dependencies

Avoid hardcoding AZs — use data "aws_availability_zones" if dynamic discovery is needed



🔖 Naming Convention


Use consistent and descriptive naming:
<project>-<env>-<region>
e.g.
todo-dev-us-east-1
mkx-prod-ap-south-1


📈 Future Enhancements


VPC Flow Logs

Transit Gateway support

IPv6 CIDR support

Dedicated subnets for database, Lambda, and bastion

PrivateLink endpoints


🙋 Author


Mukund Kale
Cloud Architect | DevOps Engineer | Terraform | AWS
GitHub: github.com/mukundkale


📄 License
This module is licensed under the MIT License.