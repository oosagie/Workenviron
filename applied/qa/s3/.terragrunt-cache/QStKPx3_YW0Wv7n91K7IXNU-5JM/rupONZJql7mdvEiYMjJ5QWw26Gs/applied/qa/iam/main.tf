module "iam_group" {
    source = "../../..//modules/groups"
    
    group_name = "cloudsentrics-qa"
    policy_name = "cloudsentrics-managed-policies"
    policy_description = "cloudsentrics-qa-policies"
    inline_policy_to_attach = data.aws_iam_policy_document.qa_inline_policy.json 
    managed_policy_to_attach = [
        "arn:aws:iam::policy/AmazonS3FullAccess",
        "arn:aws:iam::policy/AmazonEC2FullAccess"
    ]
}

data "aws_iam_policy_document" "qa_inline_policy" {
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




