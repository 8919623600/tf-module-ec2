output "PUBLIC_SUBNET_IDS" {
    value = module.vpc.PUBLIC_SUBNET_IDS

  }

#    output "private_subnet" {
#     value = module.vpc.private_subnet.*.id
#   }