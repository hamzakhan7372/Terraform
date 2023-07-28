provider "aws" {
  region = "us-east-1"  # Change this to your desired region
}

### Cluster
resource "aws_ecs_cluster" "tf-ecs-cluster" {
  name = "tf-ecs-cluster"
}

### Task Definition
resource "aws_ecs_task_definition" "tf-ecs-cluster-task-def-1" {
  family                = "tf-ecs-cluster-task-def-1"
  container_definitions = jsonencode([
    # First container
    {
      name      = "first-container"
      image     = "qhamza987/node-webserver:latest"
      essential = true
      memory    = 512  # Specify the memory in MiB for the container
      portMappings = [{
        containerPort = 80
        hostPort      = 80
      }]
    }
  ])

  network_mode             = "awsvpc"  # Use awsvpc network mode for ALB compatibility
  requires_compatibilities = ["EC2"]   # Use EC2 launch type instead of Fargate
}

### Data Source
data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_subnet" "default_subnet_1" {
  id = "subnet-096b7fe9bfdf5eb4d"  # Replace with your subnet ID
}

data "aws_subnet" "default_subnet_2" {
  id = "subnet-00334d88a0d307052"  # Replace with your subnet ID
}

### Load Balancer
resource "aws_lb" "ecs_alb" {
  name               = "my-ecs-alb-for-tf-service"
  load_balancer_type = "application"
  subnets            = [data.aws_subnet.default_subnet_1.id, data.aws_subnet.default_subnet_2.id]
}

resource "aws_lb_target_group" "ecs_target_group" {
  name        = "tf-my-ecs-target-group"
  port        = 80  # Replace this with the port your container listens on
  protocol    = "HTTP"
  target_type = "ip"  # Use "ip" target type for EC2 launch type
  vpc_id      = data.aws_vpc.default_vpc.id
}

### Service
resource "aws_ecs_service" "aws_ecs_service" {
  name            = "tf-ecs-cluster"
  cluster         = aws_ecs_cluster.tf-ecs-cluster.id
  task_definition = aws_ecs_task_definition.tf-ecs-cluster-task-def-1.arn
  desired_count   = 1
  depends_on      = [aws_ecs_task_definition.tf-ecs-cluster-task-def-1]
  launch_type     = "EC2"  # Use EC2 launch type instead of Fargate

  network_configuration {
    subnets         = [data.aws_subnet.default_subnet_1.id, data.aws_subnet.default_subnet_2.id]
    security_groups = [aws_security_group.default_scg_1.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_target_group.arn
    container_name   = "first-container"
    container_port   = 80  # Replace this with the port your container listens on
  }
}

### Security Group (Optional)
resource "aws_security_group" "default_scg_1" {
  name_prefix = "tf-default-scg-1"

  ingress {
    description = "Allow HTTP inbound traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
