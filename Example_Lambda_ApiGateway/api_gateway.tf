
resource "aws_api_gateway_rest_api" "apig_rest_api" {
  name = var.name
}

resource "aws_api_gateway_resource" "APIGateway" {
    rest_api_id = aws_api_gateway_rest_api.apig_rest_api.id
    parent_id   = aws_api_gateway_rest_api.apig_rest_api.root_resource_id
    path_part   = var.endpoint_path
}

resource "aws_api_gateway_method" "method" {
    rest_api_id   = aws_api_gateway_rest_api.apig_rest_api.id
    resource_id   = aws_api_gateway_resource.APIGateway.id
    http_method   = "GET"
    authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
    rest_api_id = aws_api_gateway_rest_api.apig_rest_api.id
    resource_id = aws_api_gateway_resource.APIGateway.id
    http_method = aws_api_gateway_method.method.http_method
    integration_http_method = "POST"
    type = "AWS_PROXY"
    uri = aws_lambda_function.Mylambda.invoke_arn
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.Mylambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.apig_rest_api.execution_arn}/*/*/*"
  
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [aws_api_gateway_method.method,aws_api_gateway_integration.integration]
  rest_api_id = aws_api_gateway_rest_api.apig_rest_api.id
}

resource "aws_api_gateway_stage" "stage" {
deployment_id = aws_api_gateway_deployment.deployment.id
rest_api_id = aws_api_gateway_rest_api.apig_rest_api.id
stage_name = var.stage_name  
}



