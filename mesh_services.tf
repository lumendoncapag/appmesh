resource "aws_appmesh_mesh" "mesh" {
  name = var.mesh_name

  spec {
    egress_filter {
      type = "ALLOW_ALL"
    }
  }
}



resource "aws_appmesh_virtual_service" "musicbox" {
  name      = "musicbox-service.${var.namespace_name}"
  mesh_name = aws_appmesh_mesh.mesh.id

  spec {
    provider {
      virtual_node {
        virtual_node_name = aws_appmesh_virtual_node.musicbox-vn.name
      }
    }
  }
}

resource "aws_appmesh_virtual_service" "flamenco" {
  name      = "flamenco-service.${var.namespace_name}"
  mesh_name = aws_appmesh_mesh.mesh.id

  spec {
    provider {
      virtual_node {
        virtual_node_name = aws_appmesh_virtual_node.flamenco-vn.name
      }
    }
  }
}

resource "aws_appmesh_virtual_service" "opera" {
  name      = "opera-service.${var.namespace_name}"
  mesh_name = aws_appmesh_mesh.mesh.id

  spec {
    provider {
      virtual_node {
        virtual_node_name = aws_appmesh_virtual_node.opera-vn.name
      }
    }
  }
}