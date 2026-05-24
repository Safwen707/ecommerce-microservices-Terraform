terraform {
  backend "s3" {
    bucket         = "ecommerce-tf-state-bucket"
    key            = "prod/ecommerce-microservices/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}
