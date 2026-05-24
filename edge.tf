# WAF
resource "aws_wafv2_web_acl" "waf" {
  name        = "${var.project_name}-waf"
  description = "WAF pour la plateforme E-Commerce"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.project_name}-waf"
    sampled_requests_enabled   = true
  }
}

# API Gateway (HTTP API pour les microservices)
resource "aws_apigatewayv2_api" "api_gw" {
  name          = "${var.project_name}-api-gw"
  protocol_type = "HTTP"
}

# CloudFront CDN (Mocké pour pointer vers l'API Gateway)
resource "aws_cloudfront_distribution" "cdn" {
  enabled = true

  origin {
    domain_name = replace(aws_apigatewayv2_api.api_gw.api_endpoint, "/^https?://([^/]*).*/", "$1")
    origin_id   = "ApiGatewayOrigin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "ApiGatewayOrigin"
    
    viewer_protocol_policy = "redirect-to-https"
    
    forwarded_values {
      query_string = true
      cookies { forward = "all" }
    }
  }

  restrictions {
    geo_restriction { restriction_type = "none" }
  }

  viewer_certificate { cloudfront_default_certificate = true }
}
