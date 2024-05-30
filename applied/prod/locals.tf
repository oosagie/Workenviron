locals {
  users = {
    "james"   = "arn:aws:iam::aws:policy/ReadOnlyAccess",
    "sarah"   = "arn:aws:iam::aws:policy/ReadOnlyAccess",
    "paul"    = "arn:aws:iam::aws:policy/AdministratorAccess",
    "promise" = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  }
}

locals {
  managed_policies = {
    security   = "arn:aws:iam::aws:policy/AdministratorAccess",
    devops     = "arn:aws:iam::aws:policy/ReadOnlyAccess",
    compliance = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  }

  inline_policies = {
    security = jsonencode ({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Action = "ec2:*"
                Resource = "*"
            }
        ]
    })

    devops = jsonencode ({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Action = "s3:*"
                Resource ="*"
            }
        ]
    }) 

    compliance = jsonencode ({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Action = "cloudtrail:*"
                Resource = "*"
            }
        ]
    })
  }
}









