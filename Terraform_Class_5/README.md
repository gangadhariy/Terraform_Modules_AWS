# Atlas Core AWS Infrastructure (Terraform)

This repository contains a production-like AWS infrastructure setup using Terraform.

It provisions a full AWS stack including:

- VPC
- Public Subnets (Multi-AZ)
- Internet Gateway
- Route Tables
- Security Groups
- Application Load Balancer (ALB)
- Target Group
- Launch Template
- Auto Scaling Group (ASG)

---

## 📁 Architecture Overview

This Terraform setup creates a highly available AWS architecture:

- 1 VPC (custom network)
- 2 Public Subnets across different AZs
- Internet Gateway for internet access
- Route tables for subnet routing
- Application Load Balancer for traffic distribution
- Auto Scaling Group for EC2 instance management
- Security Groups allowing HTTP and SSH access

---

## ⚙️ Prerequisites

Before running this project, ensure you have:

- Terraform installed → https://developer.hashicorp.com/terraform/downloads
- AWS CLI configured (`aws configure`)
- IAM permissions for:
  - EC2
  - VPC
  - ELB / ALB
  - Auto Scaling
- Existing EC2 Key Pair in AWS (used in launch template)

---

## 📥 Clone the Repository

```bash
git clone https://github.com/gangadhariy/Terraform_Modules_AWS.git
cd Terraform_Modules_AWS/Terraform_Class_5
```

---

## 🧾 Create terraform.tfvars

Create a file named `terraform.tfvars` in the same directory.

### Example configuration

```hcl
atlas_core_vpc_cidrblock = "10.0.0.0/16"

atlas_core_subnet_cidrblock = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

atlas_core_subnet_azs = [
  "ap-south-1a",
  "ap-south-1b"
]

atlas_core_sg_name = "atlas-core-sg"

atlas_core_sg_inbound_ports = [
  {
    port        = 80
    description = "Allow HTTP"
    cidr_block  = ["0.0.0.0/0"]
  },
  {
    port        = 22
    description = "Allow SSH"
    cidr_block  = ["0.0.0.0/0"]
  }
]

atlas_core_tg_name = "atlas-core-tg"
atlas_core_lb_name = "atlas-core-alb"

atlas_core_lt_name   = "atlas-core-lt"
atlas_core_lt_ami_id = "ami-0abcdef1234567890"

atlas_core_asg_azs = [
  "ap-south-1a",
  "ap-south-1b"
]
```

---

## 🚀 Deployment Steps

### 1. Initialize Terraform
```bash
terraform init
```

### 2. Validate configuration
```bash
terraform validate
```

### 3. Plan infrastructure
```bash
terraform plan
```

### 4. Apply infrastructure
```bash
terraform apply
```

Type `yes` when prompted.

---

## 🌐 Access Application

After deployment:

- Go to AWS Console → EC2 → Load Balancers
- Copy ALB DNS name
- Open in browser:

```
http://<alb-dns-name>
```

---

## 🧹 Destroy Infrastructure

To remove all resources:

```bash
terraform destroy
```

---

## 📌 Important Notes

- Ensure AMI ID is valid for your region (ap-south-1 recommended)
- Key pair `Devops-learn` must exist in AWS
- S3 bucket for ALB logs must exist (`gng-lmd-test-bucket`)
- Subnets must match availability zones

---

## 🧠 Learning Outcomes

This project helps you understand:

- AWS VPC networking
- ALB + Target Group flow
- Auto Scaling architecture
- Terraform infrastructure provisioning
- Real-world DevOps deployment patterns
