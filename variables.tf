variable "server_url" {
  description = "Tableau server URL"
  type        = string
}

variable "username" {
  description = "Tableau username"
  type        = string
}

variable "password" {
  description = "Tableau password"
  type        = string
  sensitive   = true
}

variable "site_name" {
  description = "Tableau site name"
  type        = string
}

variable "test_user_email" {
  description = "Email for the test user"
  type        = string
}

variable "test_user_name" {
  description = "Full name for the test user"
  type        = string
}
