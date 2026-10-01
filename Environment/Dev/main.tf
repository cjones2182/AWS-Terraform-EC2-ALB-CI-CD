module "vpc" {
  source = "../../modules/vpc"
}
module "security-groups" {
  source = "../../modules/security-groups"
  vpc_id = module.vpc.vpc_id
}
module "EC2" {
  source                  = "../../modules/EC2"
  instance_security_group = module.security-groups.instance_security_group
  private_subnet_1        = module.vpc.private_subnet_1
}
module "alb" {
  source             = "../../modules/alb"
  public_subnet_1    = module.vpc.public_subnet_1
  public_subnet_2    = module.vpc.public_subnet_2
  vpc_id             = module.vpc.vpc_id
  alb_security_group = module.security-groups.alb_security_group
  aws_instance       = module.EC2.aws_instance
}
module "codebuild" {
  source = "../../modules/codebuild"
}
