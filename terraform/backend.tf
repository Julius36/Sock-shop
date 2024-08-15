terraform {
  
    backend "s3" {
      bucket = "altschool-bucket-project-1202"
      key = "eks-cluster/terraform.tfstate"
      region = "us-east-1"
      encrypt = true
    }
}