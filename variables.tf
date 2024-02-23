variable "mesh_name" {
  default = "musicbox-mesh"
}


variable "namespace_name" {
  default = "ecs-course.local"
}

variable "ecs_cluster_name" {
  default = "ecs-course-fargate"

}

variable "subnets" {
  default = ["subnet-0c38f22bf38edf493", "subnet-0f3f1b1d87f9616ee"]

}

variable "sg_be" {
  default = ["sg-0a0744b34f461f57a"]

}

variable "sg_fe" {
  default = ["sg-0f2e3b907b85d816e"]

}

variable "fe_port" {
  default = "9000"
}

variable "tag"{
  default = "1.0"
}