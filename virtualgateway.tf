###############################
###### VIRTUAL GATEWAY ########
###############################
variable "gateway_routes" {
  default = [
    {
      name    = "route-flamenco"
      service = "flamenco-service.ecs-course.local"
      path    = "/flamenco"
    },
    {
      name    = "route-opera"
      service = "opera-service.ecs-course.local"
      path    = "/opera"
    }
  ]
}
resource "aws_appmesh_virtual_gateway" "virtual_gateway" {
  name      = "music-virtualgateway"
  mesh_name = var.mesh_name
  spec {
    listener {
      port_mapping {
        port     = "80"
        protocol = "http"
      }
    }
  }
}

resource "aws_appmesh_gateway_route" "virtual_gateway_route" {
  count                = length(var.gateway_routes)
  name                 = var.gateway_routes[count.index]["name"]
  mesh_name            = var.mesh_name
  virtual_gateway_name = "music-virtualgateway"

  spec {
    http_route {
      action {
        target {
          virtual_service {
            virtual_service_name = var.gateway_routes[count.index]["service"]
          }
        }
      }

      match {
        prefix = var.gateway_routes[count.index]["path"]
      }
    }
  }
  depends_on = [
    aws_appmesh_virtual_gateway.virtual_gateway
  ]

}