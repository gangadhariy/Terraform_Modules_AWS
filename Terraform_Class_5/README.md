# Atlas Core AWS Infrastructure (Terraform)

This repository contains a production-like AWS infrastructure setup using Terraform.  
It provisions a full stack including:

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

When applied, this Terraform code will create:

- A custom VPC
- 2 public subnets across different AZs
- Internet Gateway for internet access
- Route tables associated with subnets
- ALB distributing traffic
- EC2 instances managed by ASG
- Security rules for HTTP & SSH access

---

## ⚙️ Prerequisites

Make sure you have installed:

- [Terraform](https://www.terraform.io/downloads)
- AWS CLI configured (`aws configure`)
- IAM permissions for:
  - EC2
  - VPC
  - ELB
  - Auto Scaling

---

## 📥 Clone the Repository

```bash
git clone https://github.com/<your-username>/<your-repo-name>.git
cd <your-repo-name>
