variable "ami_id" {}
variable "instance_type" {}
variable "public_subnet_id" {}
variable "my_vpc_id" {}
variable "public_key" {}
variable "public_key_name" {}
variable "security_group_id" {}
variable "user_data_install_jenkins" {}

output "ec2_instance_id" {
  value = aws_instance.jenkins_instance.id
}
  
resource "aws_instance" "jenkins_instance" {
  ami = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = "jenkins_instance"
  }
  subnet_id = var.public_subnet_id
  associate_public_ip_address  = true
  vpc_security_group_ids = var.security_group_id
  user_data = var.user_data_install_jenkins
}

resource "aws_key_pair" "deployer" {
  key_name   = var.public_key_name
  public_key = var.public_key
}


