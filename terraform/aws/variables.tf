#===============================================================================
# variables
#===============================================================================

# resources
variable "prefix" {
  description = "prefix for resources"
}
variable "region" {
    description ="default aws region"
    default = "us-west-2"
}
variable "awsCreds" {
  description = "credentials from vault"
}


# admin access
variable "admin" {
  
}
variable "pass" {
  
}

variable "adminSrc" {
  
}


