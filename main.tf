

module "vpc" {
  source = "./modules/vpc"

  subnet_config = var.subnet_config
  vpc_id        = var.vpc_id

}
module "ec2" {
  source          = "./modules/ec2"
  vpc_id          = module.vpc.vpc_id
  public-sub-1-id = module.vpc.public-sub-1-id
  public-sub-2-id = module.vpc.public-sub-2-id


  instance_values = var.instance_values
  sg-name         = var.sg-name

}

module "rds" {
  source = "./modules/rds"

  vpc_id           = module.vpc.vpc_id
  sec-grp-id       = module.ec2.sec-grp-id
  private-sub-1-id = module.vpc.private-sub-1-id
  private-sub-2-id = module.vpc.private-sub-2-id



  sec-db-name    = var.sec-db-name
  name-sub-grp   = var.name-sub-grp
  rds-sub-grp    = var.rds-sub-grp
  user_id        = var.user_id
  user_pass      = var.user_pass
  instance_type  = var.instance_type
  engine         = var.engine
  engine_version = var.engine_version
  vol_type       = var.vol_type
  storage        = var.storage
  identity       = var.identity
}

module "alb" {
  source = "./modules/alb"

  vpc_id          = module.vpc.vpc_id
  public-sub-1-id = module.vpc.public-sub-1-id
  public-sub-2-id = module.vpc.public-sub-2-id
  sec-grp-id      = module.ec2.sec-grp-id


}
