terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}





# Additional provider configuration for west coast region; resources can
# reference this as `aws.west`.
provider "aws" {
 
  region = "us-west-1"
}
