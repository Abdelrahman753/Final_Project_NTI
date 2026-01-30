terraform {
  backend "s3" {
    bucket  = "nti-state-bucket"
    key     = "Infra/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}