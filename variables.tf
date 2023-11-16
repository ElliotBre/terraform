#Keys

variable "access_key" {
  type = string
  sensitive = true
}
variable "secret_key" {
  type = string
  sensitive = true
}
variable "key_name" {
  type = string
  sensitive = true 
}

# Instance Config

variable "instance_name" {
  type = string
}
variable "instance_ami" {
  type = string
}
variable "instance_region" {
  default = "eu-west-2"
  type = string
}

# Bucket Config

variable "bucket_name" {
  type = string 
}
