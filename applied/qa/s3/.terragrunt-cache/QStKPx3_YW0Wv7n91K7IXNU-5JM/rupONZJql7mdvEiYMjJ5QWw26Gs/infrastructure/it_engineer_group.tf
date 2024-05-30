module "it_engineer" {
    source = "../../..//modules/groups"
    
    group_name = "it_engineer"
    region     = "us-east-1"
    policy_name = "it_engineer-cloudsentrics-managed-policy"
    policy_description = "cloudsentrics-it_engineer-inline_policies"
    inline_policy_to_attach = data.aws_iam_policy_document.it_engineer_inline_policy.json 
    managed_policy_to_attach = [
        "arn:aws:iam::policy/AmazonS3FullAccess"
        
    ]
}

data "aws_iam_policy_document" "it_engineer_inline_policy" {
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




