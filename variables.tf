variable app_name {
  description = "The name of the application."
}

variable cluster_name {
  description = "The ECS Cluster name."
}

variable service_name {
  description = "The ECS Service name."
}

variable prod_listener_arns {
  type        = list(string)
  description = "List of Amazon Resource Names (ARNs) of the load balancer listeners."
}

variable blue_target_group {
  description = "Name of the blue target group."
}

variable green_target_group {
  description = "Name of the green target group."
}

variable auto_rollback_enabled {
  default     = true
  description = "Indicates whether a defined automatic rollback configuration is currently enabled for this Deployment Group."
}

variable auto_rollback_events {
  type        = list(string)
  default     = ["DEPLOYMENT_FAILURE", "DEPLOYMENT_STOP_ON_ALARM"]
  description = "The event type or types that trigger a rollback."
}

variable action_on_timeout {
  default     = "CONTINUE_DEPLOYMENT"
  description = "When to reroute traffic from an original environment to a replacement environment in a blue/green deployment."
}

variable wait_time_in_minutes {
  default     = 0
  description = "The number of minutes to wait before the status of a blue/green deployment changed to Stopped if rerouting is not started manually."
}

variable termination_wait_time_in_minutes {
  default     = 5
  description = "The number of minutes to wait after a successful blue/green deployment before terminating instances from the original environment."
}

variable test_listener_arns {
  type        = list(string)
  default     = []
  description = "List of Amazon Resource Names (ARNs) of the load balancer to route test traffic listeners."
}

variable iam_path {
  default     = "/"
  description = "Path in which to create the IAM Role and the IAM Policy."
}

variable description {
  default     = "Managed by Terraform"
  description = "The description of the all resources."
}

variable tags {
  default     = {}
  description = "A mapping of tags to assign to all resources."
}

variable trigger_target_arn {
  default     = []
  description = "Arn of the Amazon SNS."
}

variable trigger_events {
  default     = ["DeploymentStart", "DeploymentSuccess", "DeploymentFailure", "DeploymentStop", "DeploymentRollback", "DeploymentReady"]
  description = "Default Notification Events"
  
}
