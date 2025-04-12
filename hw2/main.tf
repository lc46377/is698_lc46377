provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source                  = "./modules/vpc"
  vpc_cidr                = "10.0.0.0/16"
  vpc_name                = "my-vpc"
  public_subnet_cidrs     = ["10.0.1.0/24", "10.0.3.0/24"]
  public_subnet_azs       = ["us-east-1a", "us-east-1b"]
  private_subnet_cidrs    = ["10.0.2.0/24"]
  private_subnet_azs      = ["us-east-1a"]
}

module "ec2" {
  source           = "./modules/ec2"
  ami_id           = "ami-07a6f770277670015"
  instance_type    = "t2.micro"
  key_name         = "MyKeyPair"
  private_subnet_id= module.vpc.private_subnet_ids[0]
  instance_name    = "private-web-server"
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = "terraform-lc46377-hw2"
}

module "dynamodb" {
  source      = "./modules/dynamodb"
  table_name  = "UserLoginsTable"
  read_capacity  = 5
  write_capacity = 5
}
