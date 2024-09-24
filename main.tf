# Use AWS provider
provider "aws" {
  region = var.aws_region
}

# ECS Cluster for Medusa
resource "aws_ecs_cluster" "medusa_cluster" {
  name = "medusa-ecs-cluster"
}

# ECS Task Definition
resource "aws_ecs_task_definition" "medusa_task" {
  family                   = "medusa-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.existing_ecs_task_execution_role_arn  # Use existing role ARN

  container_definitions = jsonencode([{
    name      = "medusa-container"
    image     = "jaswanthreddi/medusa-app:latest"
    essential = true
    portMappings = [{
      containerPort = 9000
      hostPort      = 9000
      protocol      = "tcp"
    }]
    environment = [
      {
        name  = "DATABASE_URL"
        value = "postgres://postgres:Jashu@3337@localhost:5432/my_medusa_db"
      },
      {
        name  = "JWT_SECRET"
        value = "something"
      }
    ]
  }])
}

# ECS Service for Medusa
resource "aws_ecs_service" "medusa_service" {
  name            = "medusa-service"
  cluster         = aws_ecs_cluster.medusa_cluster.id
  task_definition = aws_ecs_task_definition.medusa_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.existing_subnet_ids
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }
}

# Security Group for ECS Fargate
resource "aws_security_group" "ecs_sg" {
  name        = "ecs-sg"
  description = "Allow inbound traffic for Medusa ECS Fargate"

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = var.existing_vpc_id
}

