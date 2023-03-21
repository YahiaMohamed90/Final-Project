provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}


resource "aws_ecrpublic_repository" "public-ecr" {
  provider = aws.us_east_1

  repository_name = "public-ecr"

  catalog_data {
    about_text        = "About Text"
    architectures     = ["ARM"]
    description       = "Description"
    operating_systems = ["Linux"]
    usage_text        = "Usage Text"
  }

  tags = {
    env = "dev"
  }
}



data "aws_iam_policy_document" "ecr-doc" {
  statement {
    sid    = "new policy"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:DeleteRepository",
      "ecr:BatchDeleteImage",
      "ecr:SetRepositoryPolicy",
      "ecr:DeleteRepositoryPolicy",
    ]
  }
}



resource "aws_ecrpublic_repository_policy" "ecr-policy" {
  repository_name = aws_ecrpublic_repository.public-ecr.repository_name
  policy          = data.aws_iam_policy_document.ecr-doc.json


}
