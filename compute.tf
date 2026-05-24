resource "aws_ecs_cluster" "microservices" {
  name = "${var.project_name}-cluster"
}

# Définition générique réutilisable pour les 5 microservices
locals {
  services = ["shopping-cart", "product-catalog", "order-management", "checkout", "payment-processing"]
}

resource "aws_ecs_task_definition" "tasks" {
  for_each                 = toset(local.services)
  family                   = "${var.project_name}-${each.key}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name  = each.key
      image = "nginxdemos/hello:latest" # Image placeholder
      portMappings = [{ containerPort = 80 }]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/${var.project_name}/${each.key}"
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "services" {
  for_each        = toset(local.services)
  name            = each.key
  cluster         = aws_ecs_cluster.microservices.id
  task_definition = aws_ecs_task_definition.tasks[each.key].arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = module.vpc.private_subnets
    assign_public_ip = false
  }
}
