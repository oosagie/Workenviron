module "security_group" {
    source = "../../..//modules/groups"
    
    policy_name = "security_group-policy"
    region     = "us-east-1"
    policy_description = "cloudsentrics-security_group-policies"
    inline_policy_to_attach = data.aws_iam_policy_document.security_group_inline_policy.json 
    managed_policy_to_attach = [
        "arn:aws:iam::policy/AmazonS3FullAccess"
        
    ]
}

data "aws_iam_policy_document" "security_group_inline_policy" {
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




