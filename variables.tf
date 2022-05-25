######################################################
##                      Project                     ##
######################################################
variable "project_name" {
  description = "Project name here"
  default     = "TMS"
}

######################################################
##                     Region                       ##
######################################################
# Region variable
variable "region" {
  description = "Region for the the system"
  default     = "eu-west-1"
}

######################################################
##                     VPC                          ##
######################################################

variable "VPC_ID" {
  description = "customer VPC for the the system"
  default = "vpc-03e36a5efc08f7262"
}

######################################################
##                      IAM Role                    ##
######################################################

variable "aws_iam_role_name" {
  description = "Role name for lambda function"
  default = "s3-recycle"
}


######################################################
##                       Others                     ##
######################################################

variable "cluster_name" {
  description = "eks cluster name"
  default = "TMS01"
}

variable "vpn_private_subnets" {
  description = "eks private subnet name"
  default = "subnet-0fece53823c17eabe"
}
