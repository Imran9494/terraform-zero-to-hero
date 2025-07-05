variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"

}

variable "instance_type_value" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"

}

variable "ami_id_value" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-020cba7c55df1f615" # Replace with a valid AMI ID

}