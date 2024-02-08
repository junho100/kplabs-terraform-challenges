locals {
  dev_vpc_cidr_block = "172.31.0.0/16"
  ingress_cidr_block_info = [{
    port        = 443
    cidr_blocks = [local.dev_vpc_cidr_block]
    }, {
    port        = 8080
    cidr_blocks = [local.dev_vpc_cidr_block]
    }, {
    port        = 8443
    cidr_blocks = ["${aws_eip.example.public_ip}/32"]
  }]
}

resource "aws_security_group" "security_group_payment_app" {
  name        = "payment_app"
  description = "Application Security Group"
  depends_on  = [aws_eip.example]

  dynamic "ingress" {
    for_each = local.ingress_cidr_block_info
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = var.splunk
    to_port     = var.splunk
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}