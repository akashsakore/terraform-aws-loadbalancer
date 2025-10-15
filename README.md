## Terraform Jenkins Infrastructure on AWS

## Overview
```
This project automates the provisioning of a complete Jenkins CI/CD environment on AWS using Terraform.
It follows the Infrastructure as Code (IaC) principle — where networking, security groups, EC2 instance setup, and load balancing are all defined using Terraform modules.
```

## Project Architecture

Modules used:

- Networking – Creates VPC, public and private subnets.
- Security Group – Defines inbound/outbound rules for Jenkins and Load Balancer.
- Jenkins – Launches an EC2 instance with Jenkins installed automatically via user-data script.
- Load Balancer – Deploys an Application Load Balancer (ALB) and attaches the Jenkins instance as the target.
- Target Group – Manages target group registration for ALB and Jenkins instance.

## Tech Stack

- Terraform v1.9+
- AWS Provider
- AWS EC2
- AWS VPC
- AWS ALB (Elastic Load Balancer)
- Jenkins
- Ubuntu 22.04


## Project Structure
```
/
│
├── main.tf
├── variables.tf
├── terraform.tfvars
├── terraform.tfstate
├── .gitignore
│
├── Networking/
│   └── main.tf
│
├── Security_group/
│   └── main.tf
│
├── jenkins/
│   ├── main.tf
│   └── jenkins-installer.sh
│
├── load_balancer/
│   └── main.tf
│
└── load_balancer_TG/
    └── main.tf
```

## How to Use
```
1️⃣ Clone the Repository
git clone https://github.com/<your-username>/<repo-name>.git
cd <repo-name>

2️⃣ Initialize Terraform
terraform init

3️⃣ Validate the Configuration
terraform validate

4️⃣ Review the Plan
terraform plan

5️⃣ Apply and Create Infrastructure
terraform apply -auto-approve
```

## Outputs

After successful deployment, Terraform will output:
- Jenkins Instance Public IP
- Load Balancer DNS Name
- Target Group ARN
- You can access Jenkins using:
- http://<load-balancer-dns>:8080


## Cleanup
```
To destroy all resources and avoid unwanted AWS costs:

terraform destroy -auto-approve

```
