variable "subnet_config" {
  type = map(object({
    type     = string
    new_bits = number
    netnum   = number
    az       = string
  }))
}

variable "vpc_id" {
  type = string
  default = ""
}