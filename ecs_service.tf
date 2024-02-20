resource "aws_ecs_service" "flamenco" {
  name                               = "flamenco-svs"
  cluster                            = var.ecs_cluster_name
  task_definition                    = aws_ecs_task_definition.flamencoapp.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  launch_type                        = "FARGATE"
  network_configuration {
    subnets          = var.subnets
    security_groups  = var.sg_be
    assign_public_ip = true
  }
  service_registries {
    registry_arn = aws_service_discovery_service.flamenco.arn
  }
}

resource "aws_ecs_service" "opera" {
  name                               = "opera-svs"
  cluster                            = var.ecs_cluster_name
  task_definition                    = aws_ecs_task_definition.operaapp.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  launch_type                        = "FARGATE"
  network_configuration {
    subnets          = var.subnets
    security_groups  = var.sg_be
    assign_public_ip = true
  }
  service_registries {
    registry_arn = aws_service_discovery_service.opera.arn
  }
}


resource "aws_ecs_service" "musicbox" {
  name                               = "musicbox-svs"
  cluster                            = var.ecs_cluster_name
  task_definition                    = aws_ecs_task_definition.musicboxapp.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  launch_type                        = "FARGATE"
  network_configuration {
    subnets          = var.subnets
    security_groups  = var.sg_fe
    assign_public_ip = true
  }
  service_registries {
    registry_arn = aws_service_discovery_service.musicbox.arn
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.musicbox-tg.arn
    container_name   = "musicboxapp"
    container_port   = var.fe_port
  }
}




