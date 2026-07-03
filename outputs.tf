output "vpc_id" {

  value = module.network.vpc_id

}

output "instance_id" {

  value = module.ec2.instance_id

}
