variable "aws_region" {
  description = "Région AWS de déploiement"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environnement (dev, staging, prod)"
  type        = string
  default     = "prod"
}

variable "project_name" {
  description = "Nom du projet"
  type        = string
  default     = "ecommerce-platform"
}
