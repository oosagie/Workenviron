resource "aws_iam_role" "proxy_role" {
  name = var.proxy_role

  assume_role_policy = <<EOF
{
    "Version":"2012-10-17",
    "Statement": [
        {
            "Effect":"Allow",
            "Action":"sts:AssumeRoleWithWebIdentity"
            "Principal": {
                "Federated":"arn:aws:iam::${var.account_id}:oidc-provider/token.actions.githubusercontent.com"
            },    
            "condition":{
                "StringEquals":{
                    "tokens.actions:githubusercontent.com:sub" [
                        "repo:oosagie/${var.github_repo}:pull_request
                        "repo:oosagie/${var.github_repo}:ref:refs/heads/main 
                    ] 
                }
            }
        }
    ]
}
EOF 
}

resourse "aws_iam_role_policy" "proxy_role" {
    name = var.proxy_role_policy
    role = aws_iam_role.proxy_role.id 
    policy = <<EOF 

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow"'
            "Action": [
                "sts:AssumeRoleWithWebIdentity",
                "sts:AssumeRole",
                "sts:GetSessionToken",
                "sts:GetFederationToken"
            ],
            "Resource":[
                "${aws_iam_role.worker_role.arn}"
                "${aws_iam_role.backend_role.arn}
            ]
        }
    ]
}
EOF 
}

# This is the Backend Role
resource "aws_iam_role" "backend_role" {
    name = var.backend_role

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

resource"aws_iam_policy" "backend_role_policy" {
    name = var.backend_role_policy_name

    policy = <<EOF 

{
    "Version":"2012-10-17",
    "Statement":[
        {
        
            "Effect":"Allow",
            "Action":[
                "s3:ListBucket",
                "s3:GetBucketVersioning",
                "s3:GetObject",
                "s3:GetBucketAcl",
                "s3:GetBucketLogging",
                "s3:CreateBucket",
                "s3:PutObject",
                "s3:PutBucketPublicAccessBlock",
                "s3:PutBucketTagging",
                "s3:PutBucketPolicy",
                "s3:PutBucketVersioning",
                "s3:PutEncryptionConfiguration",
                "s3:PutBucketAcl",
                "s3:PutBucketLogging",
                "dynamodb:PutItem",
                "dynamodb:GetItem",
                "dynamodb:DescribeTable",
                "dynamodb:DeleteItem",
                "dynamodb:CreateTable"
            ],
            "Resource":[
                "arn:aws:s3:::${var.s3_bucket_name}",
                "arn:aws:dynamodb:${var.aws_region}:${var.account_id}:table/${var.dynamodb_table_name}"
            ]
        }, 
        {
      
            "Effect":"Allow",
            "Action": [
               "s3:PutObject",
               "s3:GetObject"
            ],
            "Resource":"arn:aws:s3:::${var.s3_bucket_name}/*"
    }
  ]
}
EOF
}