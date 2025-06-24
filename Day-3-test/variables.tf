variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
  default = "ami-020cba7c55df1f615" # Example AMI ID, replace with a valid one
}


variable "instance_type_id" {
  description = "The instance type to use for the instance"
  type        = string
  default     = "t2.micro" # Default value, can be overridden

}