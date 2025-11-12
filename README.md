# Terraform: VPC + Public Subnet + EC2 (NGINX)
Provision a minimal AWS network and an EC2 instance accessible over HTTP/HTTPS. Security group allows inbound ports 80 and 443 from the internet.

## Architecture
[![Architecture](docs/proj00-vpc-ec2-nginx.png)](docs/proj00-vpc-ec2-nginx.png)

## What this deploys
- 1 × VPC 10.0.0.0/16
- 1 × public subnet 10.0.0.0/24
- Internet Gateway and route table with 0.0.0.0/0 route
- 1 × EC2 instance (t2.micro) with a public IP
- Security group allowing tcp/80 and tcp/443 from 0.0.0.0/0
- Project tags via locals.common_tags

## Prerequisites
- Terraform >= 1.7.0
- AWS provider ~> 5.0
- An AWS account with permissions for VPC, EC2, and networking
- Credentials exported (any one of):
  ``aws configure``  
    or environment vars: ``AWS_ACCESS_KEY_ID``, ``AWS_SECRET_ACCESS_KEY``, ``AWS_DEFAULT_REGION``

## Repo layout
``
.
├─ provider.tf
├─ networking.tf
├─ compute.tf
├─ outputs.tf          # optional; see below
└─ docs/
   └─ proj00-vpc-ec2-nginx.png
``

## Quick start
``
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
``

## After apply:
- Find the instance public IP/DNS in the Terraform outputs (add outputs.tf below) or the EC2 console.
- Test HTTP: curl http://<public-ip>.

## Clean up
``
terraform destroy
``
