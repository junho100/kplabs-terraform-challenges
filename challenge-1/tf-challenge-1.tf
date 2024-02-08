provider "aws" {
  region     = "us-east-1"
  profile = "terraformprofile"
}

provider "digitalocean" {}

terraform {
      required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
    }
  }
}


resource "aws_eip" "kplabs_app_ip" {
  domain = "standard"
}
