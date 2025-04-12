variable "ami_id" {
  description = "AMI ID for the instance (e.g., Amazon Linux 2)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "private_subnet_id" {
  description = "The ID of the private subnet where the instance will be deployed"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the instance"
  type        = string
  default     = "private-web-server"
}
