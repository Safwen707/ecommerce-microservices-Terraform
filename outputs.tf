output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.cdn.domain_name
}

output "api_gateway_endpoint" {
  value = aws_apigatewayv2_api.api_gw.api_endpoint
}

output "cognito_user_pool_id" {
  value = aws_cognito_user_pool.user_auth.id
}
