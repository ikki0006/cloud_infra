resource "aws_security_group" "alb-security-group" {
    name = "${var.env}-alb-security-group"
    description = "Allow HTTPS inbound traffic"
    vpc_id = aws_vpc.main-vpc.id
    ingress {
        //from_port = 443
        //to_port = 443
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_lb" "default-alb" {
  name = "${var.env}-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb-security-group.id]
  subnets = [
    aws_subnet.public-subnet01.id,
    aws_subnet.public-subnet02.id]
  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.log-bucket.bucket
  }

}

resource "aws_lb_target_group" "target-group" {
  name     = "${var.env}-tg01"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main-vpc.id
}

resource "aws_lb_target_group_attachment" "group_attachment" {
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = aws_instance.reverse-proxy.id
  port             = 80
}

resource "aws_lb_listener" "lisener" {
  load_balancer_arn = aws_lb.default-alb.arn
  port              = "80"
  protocol          = "HTTP"
  //ssl_policy        = "ELBSecurityPolicy-2015-05"
  //certificate_arn   = "${var.alb_config["certificate_arn"]}"

  default_action {
    target_group_arn = aws_lb_target_group.target-group.arn
    type = "forward"
  }
}

# resource "aws_lb_listener_rule" "tg2" {
#   listener_arn = aws_lb_listener.lisener.arn
#   priority = 100

#   action {
#     type = "forward"
#     target_group_arn = aws_lb_target_group.target-group.arn
#   }

#   condition {
#     host_header {
#       values = ["*"]
#     }
#   }
# }