#AWS Credentials and region
provider "aws" {
#	access_key = "${var.aws_access_key}"
#	secret_key = "${var.aws_secret_key}"
	region     = "${var.region}"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-bucket_misha"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
