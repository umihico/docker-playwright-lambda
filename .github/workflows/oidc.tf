terraform {
  backend "local" {
    path = ".terraform/oidc/terraform.tfstate"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_iam_openid_connect_provider" "github_actions" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1", "1c58a3a8518e8759bf075b76b750d4f2df264fcd", ]
}

resource "aws_iam_role" "github_actions" {
  name = "github-actions-docker-playwright-lambda"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRoleWithWebIdentity"
      Principal = {
        Federated = aws_iam_openid_connect_provider.github_actions.arn
      }
      Condition = {
        StringLike = {
          "token.actions.githubusercontent.com:sub" = [
            "repo:umihico/docker-playwright-lambda:*"
          ]
        }
      }
    }]
  })
  managed_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}

output "aws_iam_openid_connect_provider" {
  value = aws_iam_openid_connect_provider.github_actions.arn
}

output "aws_iam_role" {
  # gh secret set AWS_ROLE_ARN
  value = aws_iam_role.github_actions.arn
}
