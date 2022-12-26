Usage example:
```
include "root" {
  path = find_in_parent_folders()
}

locals {
  environment_config = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  environment        = local.environment_config.locals.environment
  aws_region         = local.environment_config.locals.aws_region
  paths              = split("/", get_path_from_repo_root())
}

terraform {
  source = "github.com/bee7ch7/aws/ecs/task-definition//."
}

inputs = {
  environment      = local.environment
  name             = basename(get_terragrunt_dir())
  container_cpu    = 256
  container_memory = 512
  //   execution_role_arn    = dependency.iam-role-execution.outputs.iam_role_arn
  //   task_role_arn         = dependency.iam-role-task.outputs.iam_role_arn
  log_retantion_period  = 7
  container_definitions = <<EOF
      [
        {
            "name": "${basename(get_terragrunt_dir())}-${local.environment}",
            "image": "nginx:latest",
            "cpu": 0,
            "portMappings": [],
            "essential": true,
            "environment": [
                {
                    "name": "ENV",
                    "value": "${local.environment}"
                }
            ],
            "mountPoints": [],
            "volumesFrom": []
        }
    ]
EOF

  ######## EXECUTION ROLE ########
  task_execution_create_role       = true
  task_execution_role_name         = "${local.environment}-${basename(get_terragrunt_dir())}-ecs-task-execution"
  task_execution_role_requires_mfa = false
  task_execution_trusted_role_services = [
    "ecs-tasks.amazonaws.com"
  ]

  ###### EXECUTION POLICIES ######
  task_execution_policies_create = true
  task_execution_policies = {

    secrets = {
      name        = "${local.environment}-${basename(get_terragrunt_dir())}-db-secret-execution"
      path        = "/"
      description = "Allow to get secrets and parameters"
      policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
          "secretsmanager:GetSecretValue",
          "ssm:GetParameters"
        ],
      "Effect": "Allow",
      "Resource": [
    "arn:aws:secretsmanager:${local.aws_region}:${get_aws_account_id()}:secret:${local.environment}/*"
  ]
    }
  ]
}
EOF
    }

    buckets = {
      name        = "${local.environment}-${basename(get_terragrunt_dir())}-s3-execution"
      path        = "/"
      description = "Allow access to S3 to get environment file"
      policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::xxx.xxx.xxx/*"
    }
  ]
}
EOF
    }
  }


  ######## TASK ROLE ########
  task_role_name         = "${local.environment}-${basename(get_terragrunt_dir())}-ecs-task"
  task_role_requires_mfa = false
  task_create_role       = true

  task_trusted_role_services = [
    "ecs-tasks.amazonaws.com"
  ]

  ###### TASK POLICIES ######
  task_policies_create = true
  task_policies = {

    secrets = {
      name        = "${local.environment}-${basename(get_terragrunt_dir())}-db-secret-task"
      path        = "/"
      description = "Allow to get secrets and parameters"
      policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
          "secretsmanager:GetSecretValue",
          "ssm:GetParameters"
        ],
      "Effect": "Allow",
      "Resource": [
    "arn:aws:secretsmanager:${local.aws_region}:${get_aws_account_id()}:secret:${local.environment}/*"
  ]
    }
  ]
}
EOF
    }

    buckets = {
      name        = "${local.environment}-${basename(get_terragrunt_dir())}-s3-task"
      path        = "/"
      description = "Allow access to S3"
      policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::xxx.xxx.xxx/*"
    }
  ]
}
EOF
    }
  }

  tags = {
    Name        = "${basename(get_terragrunt_dir())}-task-${local.environment}",
    Environment = local.environment
  }

}
```
