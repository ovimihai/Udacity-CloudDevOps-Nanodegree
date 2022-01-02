variable "aws_access_key" {
  type        = string
}

variable "aws_secret_key" {
  type        = string
}

variable "aws_session_token" {
  type        = string
}

variable "aws_region" {
  type        = string
  description = "Default region for root module"
}

variable "pj_bucket" {
  type        = string
  description = "Project bucket"
}
