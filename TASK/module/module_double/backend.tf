terraform {
  backend "s3" {
    bucket         = "hcl-tasks-bucket"
    key            = "nida/two_region/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}
