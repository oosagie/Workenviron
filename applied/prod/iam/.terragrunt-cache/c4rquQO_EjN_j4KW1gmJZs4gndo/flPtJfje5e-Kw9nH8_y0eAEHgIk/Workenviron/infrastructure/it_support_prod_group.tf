module "prod" {
    source = "../../..//modules/groups"
    
    group_name  = "prod"
    region     = "us-east-1"
    policy_name = "prod-policy"
    policy_description = "cloudsentrics-prod-policies"
    inline_policy_to_attach = data.aws_iam_policy_document.prod_inline_policy.json 
    managed_policy_to_attach = [
        "arn:aws:iam::policy/AmazonS3FullAccess"
        
    ]
}

data "aws_iam_policy_document" "developer_inline_policy" {
    statement {
        sid = ""
        actions = [
            "cloudtrail:*",
            "cloudwatch:*"
        ]
        resources = ["*"]
    }

    statement {
        sid = ""
        actions = [
            "ec2:*",
            "s3:*"
        ]
        resources = ["*"]

    }
}




