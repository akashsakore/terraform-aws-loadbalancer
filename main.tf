module "networking" {
    source = "./Networking"
    vpc_name = var.vpc_name
    vpc_cidr_block = var.vpc_cidr_block
    public_subnet_cidr = var.public_subnet_cidr
    private_subnet_cidr = var.private_subnet_cidr
    public_subnet_AZ = var.public_subnet_AZ
    }

module "security_group" {
   source = "./Security_group"
   my_vpc_id = module.networking.my_vpc_id
}

module "jenkins" {
  source = "./jenkins"
  ami_id = "ami-0360c520857e3138f"
  instance_type = var.instance_type
  my_vpc_id = module.networking.my_vpc_id
  public_subnet_id = module.networking.public_subnet_id[0]
  public_key = var.public_key
  public_key_name = var.public_key_name
  security_group_id = [module.security_group.security_group_id]
  user_data_install_jenkins = templatefile(
    "/home/akash/terraform-practice/111025/shubham-wagh-project/jenkins/jenkins-installer.sh",
    {
      TERRAFORM_VERSION = "1.9.8"
    }
    )
}
module "elb_target_group" {
  source = "./load_balencer_TG"
  my_vpc_id = module.networking.my_vpc_id
  port = 8080
  protocol = "HTTP"
  ec2_instance_id = module.jenkins.ec2_instance_id
}

module "load_balencer" {
  source = "./load_balancer"
  security_groups = [module.security_group.security_group_id]
  target_group_arn = module.elb_target_group.target_group_arn
  target_id = module.jenkins.ec2_instance_id
  public_subnet_id = module.networking.public_subnet_id
}
