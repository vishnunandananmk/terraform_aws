# AWS Infrastructure Deployment with Terraform

This repository contains a Terraform configuration to deploy a production-ready environment on AWS. The setup is designed for general application deployment and can be used for any type of application. In this example, it has been used to deploy a Django app. Environment variables are passed through AWS CodeBuild and CodePipeline, which are not managed by this Terraform script.

## Overview

This Terraform project automates the deployment of a full-stack production environment on AWS. It leverages various AWS services to handle networking, security, container orchestration, and scaling. The infrastructure is optimized for high availability and includes SSL support, autoscaling, and DNS management. Environment variables such as database and S3 endpoints are passed through AWS CodeBuild and CodePipeline for secure and automated deployments.

Key Highlight: ECS Deployment via AWS Fargate is a major feature of this setup. AWS Fargate is used to manage container deployment without the need to manage the underlying servers, providing a serverless container orchestration experience.

## Prerequisites

Before using this Terraform configuration, ensure that you have the following:

- AWS account and appropriate credentials configured.
- Terraform installed on your local machine.
- Docker installed for building the application container.

## Features

- **Automated Infrastructure Deployment**: Using Terraform, the entire infrastructure is created and configured.
- **General Application Support**: This setup is adaptable for any type of application deployment.
- **Environment Variables**: 
  - RDS host endpoint and S3 bucket endpoints are passed through AWS CodeBuild environment variables.
  - Supports environment variables via `.env` files to avoid manual input during `terraform apply`.
- **Output Information**: 
  - After deployment, the `output.tf` will return the Load Balancer endpoint for easy access.
  - Route 53 will display the NS (Name Server) records, which can be manually added to the domain provider. Alternatively, users can automate the domain provider configuration by modifying the Terraform scripts.
- **Autoscaling**: Automatically scales the ECS cluster based on traffic load.
- **SSL Support**: SSL certificates are managed through ACM and the application is accessible over HTTPS.
- **ECS Deployment via AWS Fargate**:
AWS Fargate is used to run containers without managing servers, providing a fully managed serverless experience for ECS deployments. This ensures easier management and scaling of containerized applications.

## Terraform Modules and Resources

The following AWS services are provisioned through Terraform:

- **VPC**: Configures the network infrastructure with public and private subnets.
- **ECS Cluster**: Deploys the application using Fargate.
- **RDS**: PostgreSQL instance used by the application.
- **S3 Buckets**: For static files and media.
- **ALB (Application Load Balancer)**: Handles incoming traffic and distributes it to ECS containers.
- **Route 53 DNS**: Manages DNS records for the application domain.
- **ACM**: Issues and manages SSL certificates for HTTPS traffic.
- **Auto Scaling**: Ensures the application can handle increased load.

## Usage

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/vishnunandananmk/terraform_aws.git
   cd terraform_aws
   ```

2. **Update Variables**:
   - Modify the `variables.tf` file, which includes default values but can be adjusted based on your environment.
   - Alternatively, prepare a `.env` file to pass values into Terraform automatically, avoiding the need to input them during `terraform apply`.

3. **Initialize Terraform**:
   ```bash
   terraform init
   ```

4. **Plan the Deployment**:
   Generate a Terraform execution plan:
   ```bash
   terraform plan
   ```

5. **Apply the Configuration**:
   Apply the changes to provision the infrastructure:
   ```bash
   terraform apply
   ```

6. **DNS Configuration**:
   - Once the Route 53 hosted zone is created, the NS records will be displayed.
   - You can manually update your domain provider with these NS records, or modify Terraform to automate this process if using a supported domain provider.

7. **Deployment via AWS CodePipeline**:
   - The environment variables for RDS and S3, along with other configurations, will be passed securely via AWS CodeBuild and CodePipeline.
   - The application code will be built and deployed automatically.

8. **Access the Application**:
   - After deployment, the `output.tf` file will return the Load Balancer endpoint for direct access to the application.

## AWS Services Used

- **ECR**: Stores Docker images.
- **VPC, Subnets, Internet Gateway, NAT Gateway**: Handles networking.
- **ECS (Fargate)**: Manages container deployment with a serverless experience. No need to manage the underlying infrastructure.
- **Load Balancer (ALB)**: Distributes traffic across multiple containers.
- **S3**: Stores static and media files.
- **RDS**: Stores application data using PostgreSQL.
- **Route 53**: Manages DNS and domain names.
- **ACM**: Manages SSL certificates.
- **Auto Scaling**: Adjusts ECS containers based on demand.

## Contributions

Contributions are welcome! Please create an issue or submit a pull request for any changes or improvements.
