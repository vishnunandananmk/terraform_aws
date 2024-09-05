# AWS Infrastructure Deployment for Django Project with Terraform

This repository contains a Terraform configuration to deploy a production-ready environment for a Django application on AWS. The setup leverages several AWS services, with environment variables passed through AWS CodeBuild and CodePipeline.

## Overview

This Terraform project automates the deployment of a full-stack production environment for a Django application on AWS. It leverages various AWS services to handle networking, security, container orchestration, and scaling. The environment is optimized for high availability and includes SSL support, autoscaling, and DNS management. The infrastructure is built with flexibility in mind, allowing easy adjustments for different application setups.

## AWS Services Used

- **ECR**: Stores Docker images for the Django app.
- **VPC, Subnets, Internet Gateway, NAT Gateway**: Handles networking.
- **ECS**: Runs the Django app in containers.
- **Load Balancer (ALB)**: Distributes traffic across multiple containers.
- **S3**: Stores static and media files.
- **RDS**: Stores application data using PostgreSQL.
- **Route 53**: Manages DNS and domain names.
- **ACM**: Manages SSL certificates.
- **Auto Scaling**: Adjusts ECS instances based on demand.

## Prerequisites

Before using this Terraform configuration, ensure that you have the following:

- AWS account and appropriate credentials configured.
- Terraform installed on your local machine.
- Docker installed for building the application container.

## Features

- **Automated Infrastructure Deployment**: Using Terraform, the entire infrastructure is created and configured.
- **Django Application Support**: While this is a generic app deployment setup, it has been tailored for a Django project.
- **Environment Variables**: 
  - RDS host endpoint and S3 bucket endpoints are passed through AWS CodeBuild environment variables.
  - Supports environment variables via `.env` files to avoid manual input during `terraform apply`.
- **Output Information**: 
  - After deployment, the `output.tf` will return the Load Balancer endpoint for easy access.
  - Route 53 will display the NS (Name Server) records, which can be manually added to the domain provider. Alternatively, users can automate the domain provider configuration by modifying the Terraform scripts.
- **Autoscaling**: Automatically scales the ECS cluster based on traffic load.
- **SSL Support**: SSL certificates are managed through ACM and the application is accessible over HTTPS.

## Terraform Modules and Resources

The following AWS services are provisioned through Terraform:

- **VPC**: Configures the network infrastructure with public and private subnets.
- **ECS Cluster**: Deploys the application using Fargate.
- **RDS**: PostgreSQL instance used by the Django application.
- **S3 Buckets**: For Django static files and media.
- **ALB (Application Load Balancer)**: Handles incoming traffic and distributes it to ECS containers.
- **Route 53 DNS**: Manages DNS records for the application domain.
- **ACM**: Issues and manages SSL certificates for HTTPS traffic.
- **Auto Scaling**: Ensures the application can handle increased load.

## Usage

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/your-repo.git
   cd your-repo
   ```

2. **Update Variables**:
   - Modify the `variables.tf` file, which includes default values, but can be adjusted based on your environment.
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
   - After deployment, the website will be available under your domain, or `output.tf` file will return the Load Balancer endpoint for direct access to the application.


## Contributions

Contributions are welcome! Please create an issue or submit a pull request for any changes or improvements.

## License

This project is licensed under the MIT License.
