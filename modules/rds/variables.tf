variable "vpc_id" {}
variable "sec-grp-id" {}
variable "private-sub-1-id" {}
variable "private-sub-2-id" {}


variable "sec-db-name" {
  type = string
}
variable "name-sub-grp" {
  type = string
}

variable "rds-sub-grp" {
  type = string
}

variable "user_id" {
  type = string
}

variable "user_pass" {
  type = string
}
variable "instance_type" {
  type = string
}

variable "engine" {
  type = string
}
variable "engine_version" {
  type = string
}

variable "vol_type" {
  type = string
}
variable "storage" {
  type = number
}

variable "identity" {
  type = string
}
