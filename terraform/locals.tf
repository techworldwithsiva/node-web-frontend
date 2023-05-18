locals {
  tags = {
    Name = "timing-web-frontend"
    Environment = "DEV"
    Terraform = "true"
  }
  
  app_alb_security_group_id = data.aws_ssm_parameter.app_alb_security_group_id.value
  web_alb_security_group_id = data.aws_ssm_parameter.web_alb_security_group_id.value
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  ecs_cluster_id = data.aws_ssm_parameter.ecs_cluster_id.value
  private_subent_ids = split(",",data.aws_ssm_parameter.private_subent_ids.value)
  web_target_group_arns = data.aws_ssm_parameter.web_target_group_arns.value
  container_name = "web-ecs"
  env_vars = [
    {
        "name" : "PORT"
        "value" : "3000"
    },
    {
        "name" : "API_HOST",
        "value" : "https://api.cloudcamp.in" #public URL, if URL is public then traffic from ECS web go out, and comes to AWS again.
    }
  ]

}