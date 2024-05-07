variable "project_id" {
  type = string
}

variable "region" {
  type = string
}
variable "initial_node_count" {
  type = number
}
variable "remove_default_node_pool"{
    type = bool
}
variable "node_name" {
  type = string
}

variable "node_count" {
  type = number
}

variable "preemptible" {
  type = bool
}

variable "machine_type" {
  type = string
}

variable "service_account" {
  type = string
}

variable "oauth_scopes" {
  type = list(string)
}
