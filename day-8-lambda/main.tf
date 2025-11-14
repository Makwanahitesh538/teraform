# IAM Role for Lambda
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach Basic Execution Policy
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Lambda Function
resource "aws_lambda_function" "my_lambda_function" {
  function_name = "my_lambda_function"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.handler"
  runtime       = "python3.13"  
    filename      = "lambda_function_payload.zip"
    source_code_hash = filebase64sha256("lambda_function_payload.zip")
  
   # Ensure this zip file is present in the same directory as this t

  

  description = "My test Lambda function created via Terraform"
  timeout     = 10
  memory_size = 128


}
