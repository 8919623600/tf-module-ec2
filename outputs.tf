output "public_subnet" {
    value = module.vpc.PUBLIC_SUBNET_ID

  }

#    output "private_subnet" {
#     value = module.vpc.private_subnet.*.id
#   }