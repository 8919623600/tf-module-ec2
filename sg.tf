resource "aws_security_group" "sample_sg" {
  name        = "terraform-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

  tags = {
    Name = "terraform-sg"
  }


}


resource "aws_vpc_security_group_ingress_rule" "allow_ingress" {

  dynamic ingress {
    for_each = var.ingress_rule
    content {
    description       = ingress.value["description"]
    from_port         = ingress.value["from_port"]
    to_port           = ingress.value["to_port"]
    protocol          = ingress.value["protocol"]
    cidr_blocks       = ingress.value["cidr_blocks"]
    security_group_id = ingress.value["security_group_id"]
    }
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_egress" {
   dynamic egress {
    for_each = var.egress_rule
    content {
      description       = egress.value["description"]
      from_port         = egress.value["from_port"]
      to_port           = egress.value["to_port"]
      protocol          = egress.value["protocol"]
      cidr_blocks       = egress.value["cidr_blocks"]
      security_group_id = egress_rule.value["security_group_id"]
    }
   }
}


