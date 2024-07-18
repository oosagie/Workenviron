resource "aws_iam_role" "worker_role" {
    name = var.worker_role

    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
           "Effect": "Allow",
           "Action": "sts:AssumeRole"
           "Principal": "arn:aws:iam::${var.account_id}:role/${var.proxy_role}",
           "condition": {}
        } 
    ]
}    
EOF 
}

resource"aws_iam_policy" "worker_role_policy" {
    name = var.worker_role_policy_name

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "iam*",
          ]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
}

resource "aws_iam_role_policy_attachment" "worker_role_policy_attachment" {
  role       = aws_iam_role.worker_role.name
  policy_arn = aws_iam_policy.worker_role_policy.arn 
}