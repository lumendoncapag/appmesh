##### NODE FLAMENCO APP ########

resource "aws_appmesh_virtual_node" "flamenco-vn" {
  name      = "flamenco-service-vn"
  mesh_name = aws_appmesh_mesh.mesh.id

  spec {
    listener {
      port_mapping {
        port     = 80
        protocol = "http"
      }

      health_check {
        protocol            = "http"
        path                = "/ping"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout_millis      = 2000
        interval_millis     = 5000
      }
    }

    service_discovery {
      aws_cloud_map {
        namespace_name = var.namespace_name
        service_name   = "flamenco-service"
      }
    }
  }
}

##### NODE OPERA APP ########

resource "aws_appmesh_virtual_node" "opera-vn" {
  name      = "opera-service-vn"
  mesh_name = aws_appmesh_mesh.mesh.id

  spec {
    listener {
      port_mapping {
        port     = 80
        protocol = "http"
      }

      health_check {
        protocol            = "http"
        path                = "/ping"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout_millis      = 2000
        interval_millis     = 5000
      }
    }

    service_discovery {
      aws_cloud_map {
        namespace_name = var.namespace_name
        service_name   = "opera-service"
      }
    }
  }
}

##### NODE MUSICBOX APP ########

resource "aws_appmesh_virtual_node" "musicbox-vn" {
  name      = "musicbox-service-vn"
  mesh_name = aws_appmesh_mesh.mesh.id

  spec {
    listener {
      port_mapping {
        port     = 80
        protocol = "http"
      }

      #   health_check {
      #     protocol            = "http"
      #     path                = "/ping"
      #     healthy_threshold   = 2
      #     unhealthy_threshold = 2
      #     timeout_millis      = 2000
      #     interval_millis     = 5000
      #   }
    }
    service_discovery {
      aws_cloud_map {
        namespace_name = var.namespace_name
        service_name   = "musicbox-service"
      }
    }

    backend {
      virtual_service {
        virtual_service_name = "opera-service.${var.namespace_name}"
      }
    }

    backend {
      virtual_service {
        virtual_service_name = "flamenco-service.${var.namespace_name}"
      }
    }
  }
}