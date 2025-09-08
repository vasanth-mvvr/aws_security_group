resource "aws_security_group" "sg" {
  name = local.sg_name_final
  description = var.sg_description
  vpc_id = var.vpc_id

  dynamic "egress" {
    for_each = var.out_bound
    content {
      from_port = egress.value["from_port"]
      to_port = egress.value["to_port"]
      protocol = egress.value["protocol"]
      cidr_blocks = egress.value["cidr_block"]
    }
    
  }
  dynamic "ingress" {
    for_each = var.in_bound
    content {
      from_port = ingress.value["from_port"]
      to_port = ingress.value["to_port"]
      protocol = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_block"]
    }
    
  }
  tags = merge(
    var.common_tags,
    {
        Name = local.sg_name_final
    }
    
  )

}