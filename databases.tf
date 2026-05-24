# 1. Cart Cache (ElastiCache Redis)
resource "aws_elasticache_cluster" "cart_cache" {
  cluster_id           = "${var.project_name}-cart"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.default.name
}

resource "aws_elasticache_subnet_group" "default" {
  name       = "${var.project_name}-redis-subnets"
  subnet_ids = module.vpc.private_subnets
}

# 2. Products DB (Aurora PostgreSQL)
resource "aws_rds_cluster" "products_db" {
  cluster_identifier = "${var.project_name}-products-db"
  engine             = "aurora-postgresql"
  master_username    = "dbadmin"
  master_password    = "SuperSecretPass123!" # À gérer via SecretsManager en prod
  skip_final_snapshot= true
}

# 3. Orders DB (RDS PostgreSQL Standard)
resource "aws_db_instance" "orders_db" {
  identifier           = "${var.project_name}-orders-db"
  instance_class       = "db.t3.micro"
  engine               = "postgres"
  allocated_storage    = 20
  username             = "dbadmin"
  password             = "SuperSecretPass123!"
  db_subnet_group_name = aws_db_subnet_group.default.name
  skip_final_snapshot  = true
}

resource "aws_db_subnet_group" "default" {
  name       = "${var.project_name}-rds-subnets"
  subnet_ids = module.vpc.private_subnets
}

# 4. Payments (DynamoDB)
resource "aws_dynamodb_table" "payments" {
  name           = "${var.project_name}-payments"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "TransactionId"

  attribute {
    name = "TransactionId"
    type = "S"
  }
}
