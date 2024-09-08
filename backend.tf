terraform {
  backend "s3" {
    bucket = "backend-bucket-kyaw"
    key    = "test/terraform.tfstate"
    region = "us-east-1"
  }
}