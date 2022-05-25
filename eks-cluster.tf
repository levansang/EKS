module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 18.21"
  cluster_name    = var.cluster_name
  cluster_version = "1.21"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  vpc_id = var.VPC_ID
  subnet_ids = ["subnet-0fece53823c17eabe"]

 # Self Managed Node Group(s)
  self_managed_node_group_defaults = {
    instance_type                          = "t2.medium"
    update_launch_template_default_version = true
    iam_role_additional_policies = [
      "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    ]
  }

  self_managed_node_groups = {
    one = {
      name         = "mixed-1"
      max_size     = 5
      desired_size = 2

      use_mixed_instances_policy = true
      mixed_instances_policy = {
        instances_distribution = {
          on_demand_base_capacity                  = 0
          on_demand_percentage_above_base_capacity = 10
          spot_allocation_strategy                 = "capacity-optimized"
        }

        override = [
          {
            instance_type     = "t2.large"
            weighted_capacity = "1"
          },
          {
            instance_type     = "m6i.large"
            weighted_capacity = "2"
          },
        ]
      }
    }
  }


  # EKS Managed Node Group(s)
 eks_managed_node_group_defaults = {
    disk_size      = 50
    instance_types = ["t2.medium"]
  }

  eks_managed_node_groups = {
    blue = {}
    green = {
      min_size     = 1
      max_size     = 5
      desired_size = 1

      instance_types = ["t2.medium"]
      capacity_type  = "On-demand"
    }
  }
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

