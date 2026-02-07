
region = "us-east-1"
env = "nonprod"
vpc_name = "nonprod-vpc"
vpc_cidr_block = "10.0.0.0/16"
public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
presentation_subnets = ["10.0.10.0/24", "10.0.20.0/24"]
backend_subnets = ["10.0.30.0/24", "10.0.40.0/24"]
azs = ["us-east-1a", "us-east-1b"]
eks_cluster_name = "nonprod-eks-cluster"
eks_cluster_version = "1.29"
desired_capacity = 6
max_capacity = 12
min_capacity = 1
instance_types = ["t2.micro"]
nlb_name = "nonprod-nlb"
listener_port = 80
api_name = "nonprod-api-gateway"
vpc_link_name = "nonprod-vpc-link"
tags = {
  Environment = "nonprod"
  Project     = "Final-Project"
}

ssh_key_name = "worker-key"