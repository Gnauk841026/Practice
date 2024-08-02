module "public_autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "7.7.0"
  name = "public autoscaling group"

  min_size                  = 2
  max_size                  = 2
  desired_capacity          = 2
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = module.vpc.public_subnets

  # Launch template
  launch_template_name        = "public-asg-launch-template"
  launch_template_description = "Launch template example"
  update_default_version      = true
  user_data = base64encode(file("${path.module}/install.sh"))
  key_name               = aws_key_pair.deployer.id
  network_interfaces = [
    {
      delete_on_termination = true
      device_index          = 0
      security_groups       = [module.vpc.default_security_group_id]
      associate_public_ip_address = true
    }
  ]
  target_group_arns = aws_lb_target_group.alb4public-instance.load_balancer_arns

  # # IAM role & instance profile
  # create_iam_instance_profile = false
  # iam_instance_profile_name = "example_asg_profile"

  image_id          = var.ami_ubuntu
  instance_type     = var.instance_type
  ebs_optimized     = true
  enable_monitoring = true
}

module "private_autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "7.7.0"
  name = "private autoscaling group"

  min_size                  = 2
  max_size                  = 2
  desired_capacity          = 2
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = module.vpc.private_subnets

  target_group_arns = aws_lb_target_group.nlb4private-instance.load_balancer_arns

  # Launch template
  launch_template_name        = "private-asg-launch-template"
  launch_template_description = "Launch template example"
  update_default_version      = true
  key_name               = aws_key_pair.deployer.id
  user_data = base64encode(file("${path.module}/install.sh"))
  
  network_interfaces = [
    {
      delete_on_termination = true
      device_index          = 0
      security_groups       = [module.vpc.default_security_group_id]
      associate_public_ip_address = true
    }
  ]

  # # IAM role & instance profile
  # create_iam_instance_profile = false
  # iam_instance_profile_name = "example_asg_profile"

  image_id          = var.ami_ubuntu
  instance_type     = var.instance_type
  ebs_optimized     = true
  enable_monitoring = true
}
