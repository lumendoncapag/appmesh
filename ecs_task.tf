data "template_file" "container_definitions_flamenco" {
  template = file("./ecs-taskdefinition-be.json")
  vars = {
    appname     = "flamenco"
    meshname    = var.mesh_name
    servicename = "flamenco-service-vn"
  }
}

data "template_file" "container_definitions_opera" {
  template = file("./ecs-taskdefinition-be.json")
  vars = {
    appname     = "opera"
    meshname    = var.mesh_name
    servicename = "opera-service-vn"
  }
}


data "template_file" "container_definitions_musicbox" {
  template = file("./ecs-taskdefinition-fe.json")
  vars = {
    appname      = "musicbox"
    meshname     = var.mesh_name
    servicename  = "musicbox-service-vn"
    flamencohost = "flamenco-service.${var.namespace_name}:80"
    operahost    = "opera-service.${var.namespace_name}:80"
    port         = var.fe_port
  }
}

data "template_file" "container_definitions_musicbox_virtualgateway" {
  template = file("./ecs-taskdefinition-virtualgateway.json")
  vars = {
    meshname     = var.mesh_name
    virtualgateway  = "music-virtualgateway"
  }
}

resource "aws_ecs_task_definition" "musicboxapp_vg" {
  family             = "td-musicboxvirtualgateway"
  execution_role_arn = "arn:aws:iam::058264531735:role/ecsTaskExecutionRole"
  task_role_arn      = "arn:aws:iam::058264531735:role/ecsTaskRole"
  #requires_compatibilities = ["FARGATE"]
  network_mode          = "awsvpc"
  cpu                   = 512
  memory                = 1024
  container_definitions = data.template_file.container_definitions_musicbox_virtualgateway.rendered
}



resource "aws_ecs_task_definition" "musicboxapp" {
  family             = "td-musicboxapp"
  execution_role_arn = "arn:aws:iam::058264531735:role/ecsTaskExecutionRole"
  task_role_arn      = "arn:aws:iam::058264531735:role/ecsTaskRole"
  #requires_compatibilities = ["FARGATE"]
  network_mode          = "awsvpc"
  cpu                   = 512
  memory                = 1024
  container_definitions = data.template_file.container_definitions_musicbox.rendered
  proxy_configuration {
    type           = "APPMESH"
    container_name = "envoy"
    properties = {
      AppPorts         = "80"
      EgressIgnoredIPs = "169.254.170.2,169.254.169.254"
      IgnoredUID       = "1337"
      ProxyEgressPort  = 15001
      ProxyIngressPort = 15000
    }

  }
}


resource "aws_ecs_task_definition" "flamencoapp" {
  family             = "td-flamencoapp"
  execution_role_arn = "arn:aws:iam::058264531735:role/ecsTaskExecutionRole"
  task_role_arn      = "arn:aws:iam::058264531735:role/ecsTaskRole"
  #requires_compatibilities = ["FARGATE"]
  network_mode          = "awsvpc"
  cpu                   = 512
  memory                = 1024
  container_definitions = data.template_file.container_definitions_flamenco.rendered
  proxy_configuration {
    type           = "APPMESH"
    container_name = "envoy"
    properties = {
      AppPorts         = "80"
      EgressIgnoredIPs = "169.254.170.2,169.254.169.254"
      IgnoredUID       = "1337"
      ProxyEgressPort  = 15001
      ProxyIngressPort = 15000
    }

  }
}

resource "aws_ecs_task_definition" "operaapp" {
  family             = "td-operaapp"
  execution_role_arn = "arn:aws:iam::058264531735:role/ecsTaskExecutionRole"
  task_role_arn      = "arn:aws:iam::058264531735:role/ecsTaskRole"
  #requires_compatibilities = ["FARGATE"]
  network_mode          = "awsvpc"
  cpu                   = 512
  memory                = 1024
  container_definitions = data.template_file.container_definitions_opera.rendered
  proxy_configuration {
    type           = "APPMESH"
    container_name = "envoy"
    properties = {
      AppPorts         = "${var.fe_port}"
      EgressIgnoredIPs = "169.254.170.2,169.254.169.254"
      IgnoredUID       = "1337"
      ProxyEgressPort  = 15001
      ProxyIngressPort = 15000
    }

  }
}


