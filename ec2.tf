data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "devops-workstation-image"
  owners           = ["851725330688"]


}

resource "aws_instance" "public_instance" {
  ami                     = data.aws_ami.ami.id  # fetching ami id from datasource
  instance_type           = var.instance_type
  subnet_id               = data.terraform_remote_state.vpc.outputs.PUBLIC_SUBNET_IDS[0]
  vpc_security_group_ids  = [data.terraform_remote_state.vpc.outputs.SG_ID]
  
  

  
  tags = {
    Name = "public-${var.ENV}-server"
  }
  
}

resource "aws_instance" "private_instance" {
  ami                     = data.aws_ami.ami.id  # fetching ami id from datasource
  instance_type           = var.instance_type
  subnet_id               = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS[0]
  vpc_security_group_ids  = [data.terraform_remote_state.vpc.outputs.SG_ID]

  
  tags = {
    Name = "private-${var.ENV}-server"
  }
  
}