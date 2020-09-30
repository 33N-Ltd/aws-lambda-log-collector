data "aws_s3_bucket" "compressed_logs_bucket" {
  bucket = var.s3_bucket_name
}

data "aws_iam_policy_document" "lambda_config_trust" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_config_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${data.aws_s3_bucket.compressed_logs_bucket.arn}/*",
    ]

  }

  statement {
    effect = "Allow"
    actions   = ["cloudwatch:*"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions   = ["logs:*"]
    resources = ["arn:aws:logs:*:*:*"]
  }

  statement {
    effect = "Allow"
    actions = ["kms:*"]
    resources = ["*"]
  }
}
