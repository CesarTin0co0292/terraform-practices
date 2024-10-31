

resource "aws_lambda_function" "Mylambda" {
  function_name = var.function_name
  role          = aws_iam_role.lambda_role_execution.arn
  handler       = "exports.handler"
  runtime       = "nodejs12.x"
  filename      = "example_lambda.zip"

  depends_on = [ aws_iam_role.lambda_role_execution ]
}

resource "aws_iam_role" "lambda_role_execution" {
  name = "example_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
  }
  
resource "aws_cloudwacth_log_group" "cloudwacth_log_group" {
  name = "/aws/lambda/${MyLambda.function_name}"
  retention_in_days = 14
}

resource "aws_iam_policy" "lambda_logging_policy" {
  name = "lambda_logging_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
  
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
 role = aws_iam_role.lambda_role_execution.name
 policy_arn = aws_iam_policy.lambda_logging_policy.arn  
}

