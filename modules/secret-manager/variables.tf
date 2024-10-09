variable "secret_name" {
  description = "Name of the secret in AWS Secrets Manager"
  type        = string
}

variable "secret_value" {
  description = "Value to store in the secret"
  type        = string
}