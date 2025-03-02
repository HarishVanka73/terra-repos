variable "instance_values" {
  type = map(object({
    ami           = string
    instance_type = string
    key_name      = string
    type          = string
  }))
}

variable "sg-name" {
  type = string
}



variable "vpc_id" {}
variable "public-sub-1-id" {}
variable "public-sub-2-id" {}