terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.59.0"
    }
  }

  backend "s3" {
    bucket = "terraform-provisioners"
    key    = "provisioners-key"  # Here you mention any name, this key is nth but terraform.tfstate in normal state, but now we are creating remote-state # For every project you please mention different key, combining the both project is not good
    region = "us-east-1"
    dynamodb_table = "provisioners-table"  # This dynamodb_table is for locking mechanism to our s3 bucket,(Partition key: LockID), you create any table but Partition key is same
  }
}

provider "aws" {
    region = "us-east-1"
  # Configuration options
}


# In this provider don't mention your credentials
# region only mention