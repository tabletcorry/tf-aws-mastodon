variable "name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "primary_domain_name" {
  type = string
}

variable "host_name" {
  type = string
}