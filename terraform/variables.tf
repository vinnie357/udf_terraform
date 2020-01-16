#===============================================================================
# Lab variables
#===============================================================================

variable "projectPrefix" {
    description = "prefix for resources"
    default = "devopsws01-"
}

#====================#
# admin   connection #
#====================#

variable "adminSrcAddr" {
  description = "admin source range in CIDR x.x.x.x/24"
  default = "10.0.0.0/8"
}

variable "sshKeyPath" {
  description = "path to ssh public key"
  # C:\Users\user\.ssh\user
  default ="/home/ubuntu/keys/user"
}

variable "vaultToken" {
    description = "your vault token"
    default = "root"
}
