data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "devops-workstation-image"
  owners           = ["851725330688"]


}
resource "aws_instance" "public_instance" {
  ami                     = data.aws_ami.ami.id  # fetching ami id from datasource
  instance_type           = var.instance_type
  subnet_id               = var.pub_subnet_id
  
  tags = {
    Name = "public-${var.ENV}-server"
  }

}

resource "aws_instance" "private_instance" {
  ami                     = data.aws_ami.ami.id  # fetching ami id from datasource
  instance_type           = var.instance_type
  subnet_id               = module.vpc.aws_subnet.private_subnet[0].id
  
  tags = {
    Name = "private-${var.ENV}-server"
  }

}