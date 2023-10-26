resource aws_codedeploy_app default {
  compute_platform = "ECS"
  name             = var.app_name
}

resource aws_codedeploy_deployment_group default {
  app_name               = aws_codedeploy_app.default.name
  deployment_group_name  = var.app_name
  service_role_arn       = aws_iam_role.default.arn
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  auto_rollback_configuration {
    enabled = var.auto_rollback_enabled
    events  = var.auto_rollback_events
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = var.action_on_timeout

      wait_time_in_minutes = var.wait_time_in_minutes
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = var.termination_wait_time_in_minutes
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = var.cluster_name
    service_name = var.service_name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = var.prod_listener_arns
      }

      target_group {
        name = var.blue_target_group
      }

      target_group {
        name = var.green_target_group
      }

      test_traffic_route {
        listener_arns = var.test_listener_arns
      }
    }
  }

  dynamic trigger_configuration {
    for_each = toset(var.trigger_target_arn)
    content {
      trigger_target_arn = trigger_configuration.value
      trigger_name       = format("%s-notif", var.app_name)
      trigger_events     = var.trigger_events
    }
  }

}

resource aws_iam_role default {
  name               = local.iam_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  path               = var.iam_path
  description        = var.description
  tags               = merge({"Name" = local.iam_name}, var.tags)
}

data aws_iam_policy_document assume_role_policy {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }
  }
}

resource aws_iam_policy default {
  name        = local.iam_name
  policy      = data.aws_iam_policy_document.policy.json
  path        = var.iam_path
  description = var.description
}

data aws_iam_policy_document policy {
  statement {
    effect = "Allow"

    actions = [
      "iam:PassRole",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "ecs:DescribeServices",
      "ecs:CreateTaskSet",
      "ecs:UpdateServicePrimaryTaskSet",
      "ecs:DeleteTaskSet",
      "cloudwatch:DescribeAlarms",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "sns:Publish",
    ]

    resources = ["arn:aws:sns:*:*:*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:ModifyListener",
      "elasticloadbalancing:DescribeRules",
      "elasticloadbalancing:ModifyRule",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "lambda:InvokeFunction",
    ]

    resources = ["arn:aws:lambda:*:*:function:*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectMetadata",
      "s3:GetObjectVersion",
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:ExistingObjectTag/UseWithCodeDeploy"
      values   = ["true"]
    }

    resources = ["*"]
  }
}

resource aws_iam_role_policy_attachment default {
  role       = aws_iam_role.default.name
  policy_arn = aws_iam_policy.default.arn
}

resource aws_iam_role_policy_attachment cognito {
  role       = aws_iam_role.default.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonCognitoReadOnly" # Cognito + Google認証をLBにつけた際に必要
}

locals {
  iam_name = format("%s-ecs-codedeploy", var.app_name)
}
