variable "region" {
  description = "The AWS region to create resources in."
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name to use in resource names"
  default     = "django-aws-tf"
}

variable "availability_zones" {
  description = "Availability zones"
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "ecs_prod_backend_retention_days" {
  description = "Retention period for backend logs"
  default     = 30
}


variable "db_name" {
  description = "The name of the RDS database."
  type        = string
}

variable "db_instance_class" {
  description = "The instance type for the RDS instance (e.g., db.t3.micro)."
  type        = string
}

variable "db_username" {
  description = "The username for the RDS instance."
  type        = string
}

variable "db_password" {
  description = "The password for the RDS instance."
  type        = string
  sensitive   = true
}

variable "prod_media_bucket" {
  description = "S3 Bucket for production media files"
  type        = string
  default     = "prod-media-bucket"
}

variable "account_id" {
  description = "The AWS account ID to ensure the bucket name is unique"
  type        = string
  default     = "223647876635"
}
