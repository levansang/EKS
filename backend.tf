terraform {
  backend "s3" {
    bucket         = "01-terraform-backend/01_state/"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "01_terraform_state"
  }
}
