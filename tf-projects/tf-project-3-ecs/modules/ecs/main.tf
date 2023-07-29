resource "aws_ecs_cluster" "tf-ecs-practice-cluster" {
    name = "tf-ecs-practice-cluster"
    setting {
      name = "containerInsights"
      value = "enabled"
    }
}

resource "aws_ecs_task_definition" "tf-ecs-taskdef" {
    family = "tf-ecs-taskdef"
    network_mode = "awsvpc"
    requires_compatibilities = [ "FARGATE" ]
    cpu                      = 1024
    memory                   = 2048
    container_definitions = jsonencode([
        {
        name      = "first-cont"
        image     = "nginx:latest"
        cpu       = 10
        memory    = 512
        essential = true
        portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }]
        }
    ])
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

resource "aws_ecs_service" "tf-ecs-service" {
    name = "tf-ecs-service"
    cluster = aws_ecs_cluster.tf-ecs-practice-cluster.id
    task_definition = aws_ecs_task_definition.tf-ecs-taskdef.arn
    desired_count = 1
    launch_type = "FARGATE"
    network_configuration {
    subnets         = [data.aws_subnet.default_subnet_1.id, data.aws_subnet.default_subnet_2.id]
    security_groups = [aws_security_group.default_scg_1.id]
  }
}