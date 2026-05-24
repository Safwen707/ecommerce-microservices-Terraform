# E-Commerce Platform - AWS Microservices

Ce projet Terraform déploie l'infrastructure d'une plateforme E-Commerce basée sur des microservices hébergés sur AWS ECS Fargate, conformément à la topologie définie.

## Architecture
* **Edge & Routing** : CloudFront CDN, AWS WAF, API Gateway.
* **Authentification** : Amazon Cognito.
* **Compute (ECS Fargate en Private Subnet)** :
  * Shopping Cart
  * Product Catalog
  * Order Management
  * Checkout
  * Payment Processing
* **Event Bus (Asynchrone)** : SNS Topics, SQS Queues.
* **Data Stores** : ElastiCache (Cart), Aurora (Products), RDS (Orders), DynamoDB (Payments).
* **Observabilité** : CloudWatch.

## Déploiement
1. Initialiser le backend : `terraform init`
2. Valider le plan : `terraform plan`
3. Appliquer l'infrastructure : `terraform apply`
# ecommerce-microservices-Terraform
# ecommerce-microservices-Terraform
# ecommerce-microservices-Terraform
