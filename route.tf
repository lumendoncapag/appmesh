resource "aws_appmesh_virtual_router" "flamenco-vr" {
  name      = "flamenco-vr"
  mesh_name = aws_appmesh_mesh.mesh.id

  spec {
    listener {
      port_mapping {
        port     = 80
        protocol = "http"
      }
    }
  }
}

resource "aws_appmesh_route" "flamenco-route" {
  name                = "flamenco-route"
  mesh_name           = aws_appmesh_mesh.mesh.id
  virtual_router_name = aws_appmesh_virtual_router.flamenco-vr.name

  spec {
    http_route {
      match {
        prefix = "/"
      }

      action {
        weighted_target {
          virtual_node = aws_appmesh_virtual_node.flamenco-vn.name
          weight       = 1
        }
      }
    }
  }
}