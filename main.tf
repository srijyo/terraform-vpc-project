module "network" {

  source = "./modules/network"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  az                  = var.az

}

module "ec2" {

  source = "./modules/ec2"

  subnet_id = module.network.private_subnet_id

  vpc_id = module.network.vpc_id

}
