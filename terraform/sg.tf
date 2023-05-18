#This SG is attached API ECS
resource "aws_security_group" "web_ecs" {
    name        = "timing-ecs-web"
    description = "This will only allow traffic from API ALB"
    vpc_id      = local.vpc_id

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
}

# allowing traffic only from web ALB to web ECS
resource "aws_security_group_rule" "web_ecs_rule" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  security_group_id = aws_security_group.web_ecs.id
  source_security_group_id = local.web_alb_security_group_id
}

#allowing traffic from Web ECS on 443 only to API ALB
resource "aws_security_group_rule" "api_ecs_rule" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = local.app_alb_security_group_id
  source_security_group_id = aws_security_group.web_ecs.id
}