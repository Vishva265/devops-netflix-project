# Beginner AWS Terraform Deployment

This is the simple first-project version:

- One EC2 server
- One public subnet
- One security group
- Docker running your frontend and backend containers
- MongoDB Atlas free cluster for the database

No Load Balancer, ECS, ECR, NAT Gateway, CloudFront, or paid production-style services.

## Before You Start

Create these first:

- AWS account
- EC2 key pair in AWS
- MongoDB Atlas free cluster
- Docker Hub account
- Terraform installed
- AWS CLI configured with `aws configure`

## 1. Build and Push Docker Images

From the project root:

```powershell
docker build -t your-dockerhub-username/netflix-backend:latest ./server
docker push your-dockerhub-username/netflix-backend:latest

docker build -t your-dockerhub-username/netflix-frontend:latest ./client
docker push your-dockerhub-username/netflix-frontend:latest
```

## 2. Create Your Terraform Variables

```powershell
cd terraform
copy terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars`:

```hcl
project_name  = "netflix-clone"
aws_region    = "ap-south-1"
ami_id        = "ami-0f5ee92e2d63afc18"
instance_type = "t2.micro"
key_name      = "your-ec2-key-pair-name"

frontend_docker_image = "your-dockerhub-username/netflix-frontend:latest"
backend_docker_image  = "your-dockerhub-username/netflix-backend:latest"

mongo_db_url = "mongodb+srv://USER:PASSWORD@cluster.example.mongodb.net/netflix"
jwt_secret   = "replace-with-a-long-random-secret"
```

Do not commit `terraform.tfvars` because it contains secrets.

## 3. Deploy

```powershell
terraform init
terraform plan
terraform apply
```

After apply finishes, Terraform prints `frontend_url`. Open that URL in your browser.

## 4. Update the Website Later

Build and push new images:

```powershell
docker build -t your-dockerhub-username/netflix-backend:latest ./server
docker push your-dockerhub-username/netflix-backend:latest

docker build -t your-dockerhub-username/netflix-frontend:latest ./client
docker push your-dockerhub-username/netflix-frontend:latest
```

Then SSH into EC2 and restart:

```powershell
ssh -i your-key.pem ubuntu@YOUR_EC2_PUBLIC_IP
cd /opt/netflix-clone
sudo docker compose pull
sudo docker compose up -d
```

## Destroy When Finished

To avoid charges:

```powershell
terraform destroy
```

