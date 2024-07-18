terraform {
  backend "s3" {
    bucket         = "hcl-tasks-bucket"
    key            = "dp-ansible/terraform.tfstate"
    region         = "us-east-1"
    #dynamodb_table = "terraform-lock"
  }
}
