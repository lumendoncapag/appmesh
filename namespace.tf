resource "aws_service_discovery_private_dns_namespace" "ecs" {
  name        = "ecs-course.local"
  description = "Utilizado no ecs-course"
  vpc         = data.aws_vpc.vpc.id
}

resource "aws_service_discovery_service" "flamenco" {
  name = "flamenco-service"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.ecs.id

    dns_records {
      ttl  = 60
      type = "A"
    }
  }
}

resource "aws_service_discovery_service" "opera" {
  name = "opera-service"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.ecs.id

    dns_records {
      ttl  = 60
      type = "A"
    }
  }
}

resource "aws_service_discovery_service" "musicbox" {
  name = "musicbox-service"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.ecs.id

    dns_records {
      ttl  = 60
      type = "A"
    }
  }
}