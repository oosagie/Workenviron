module "it_engineer_prod" {
    source = "../../..//modules/group"
    
    group_name = "it_engineer_prod"
    region     = "us-east-1"
    policy_name = "it_engineer-cloudsentrics-managed-policy"
    policy_description = "cloudsentrics-it_engineer_prod-inline_policies"
    inline_policy_to_attach = data.aws_iam_policy_document.it_engineer_inline_policy.json 
    managed_policy_to_attach = [
        "arn:aws:iam::policy/AmazonS3FullAccess"
        
    ]
}

data "aws_iam_policy_document" "it_engineer_prod_inline_policy" {
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




