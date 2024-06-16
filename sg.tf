resource "aws_security_group" "sample_sg" {
  name        = "my_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

tags = {
    Name = "roboshop-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  
  dynamic ingress {
    security_group_id = aws_security_group.sample_sg.id
    for_each = var.ingress_rule
    content {
    description     = ingress.value["description"]
    from_port       = ingress.value["from_port"]
    to_port         = ingress.value["to_port"]
    protocol        = ingress.value["protocol"]
    cidr_blocks     = ingress.value["cidr_blocks"]
    }
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
 
   dynamic egress {
    security_group_id = aws_security_group.sample_sg.id
    for_each = var.egress_rule
    content {
      description     = egress.value["description"]
      from_port       = egress.value["from_port"]
      to_port         = egress.value["to_port"]
      protocol        = egress.value["protocol"]
      cidr_blocks     = egress.value["cidr_blocks"]
    }
   }

}
  