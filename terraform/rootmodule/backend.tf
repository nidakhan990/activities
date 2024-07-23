terraform {
  backend "s3" {
    bucket = "hcl-tasks-bucket"
    key    = "nida-backup/terraform.tfsate"
    region = "us-east-1"
  }
}
