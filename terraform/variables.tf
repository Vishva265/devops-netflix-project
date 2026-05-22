variable "project_name" {
  description = "Name prefix used for AWS resources."
  type        = string
  default     = "netflix-clone"
}

variable "aws_region" {
  description = "AWS region for the application infrastructure."
  type        = string
  default     = "ap-south-1"
}

variable "ami_id" {
  description = "Ubuntu AMI ID for your AWS region. The default is Ubuntu 22.04 in ap-south-1."
  type        = string
  default     = "ami-0f5ee92e2d63afc18"
}

variable "instance_type" {
  description = "EC2 size. Use a free-tier eligible type if your AWS account supports it."
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Existing AWS EC2 key pair name for SSH access."
  type        = string
}

variable "ssh_cidr_block" {
  description = "IP range allowed to SSH into the server. Use your-ip/32 instead of 0.0.0.0/0 when possible."
  type        = string
  default     = "0.0.0.0/0"
}

variable "frontend_docker_image" {
  description = "Docker image for the React frontend."
  type        = string
}

variable "backend_docker_image" {
  description = "Docker image for the Express backend."
  type        = string
}

variable "mongo_db_url" {
  description = "MongoDB connection string. MongoDB Atlas free tier is a good beginner option."
  type        = string
  sensitive   = true
}

variable "jwt_secret" {
  description = "JWT signing secret for the Express API."
  type        = string
  sensitive   = true
}
