# Hardcoded value for the existing VPC ID
variable "existing_vpc_id" {
  description = "The ID of the existing VPC to be used for the ECS deployment"
  type        = string
  default     = "vpc-02aca3c29abc1cd43"
}

# Hardcoded value for the existing subnet IDs
variable "existing_subnet_ids" {
  description = "A list of the existing subnet IDs within the VPC"
  type        = list(string)
  default     = ["subnet-0eea857c1cf095bf7", "subnet-065b60dbd16e27db5","subnet-0a308cdbbeacd148b", "subnet-0c8e1c76292e064a0", "subnet-00a37eaefc5a11f57", "subnet-0fa9da9fc82cbcb3f"]  # Replace with your actual subnet IDs
}

# Hardcoded AWS region
variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"  # Replace with your desired AWS region
}
variable "existing_ecs_task_execution_role_arn" {
  default = "arn:aws:iam::202533508516:role/ecsTaskExecutionRole"
}