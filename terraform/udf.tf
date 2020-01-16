#===============================================================================
# Create lab infra
#===============================================================================


provider "vault" {
  # It is strongly recommended to configure this provider through the
  # environment variables described above, so that each user can have
  # separate credentials set in the environment.
  #
  # This will default to using $VAULT_ADDR
  # But can be set explicitly
  address = "http://vault.f5lab.internal:30000"
  token = "${var.vaultToken}"
}

data "vault_generic_secret" "bigip" {
  path="secret/bigip"
}
data "vault_generic_secret" "aws_pub_key" {
  path="secret/aws_key"
}

data "vault_generic_secret" "aws" {
  path="secret/aws"
}

resource "vault_generic_secret" "example" {
  path = "secret/foo"

  data_json = <<EOT
{
  "foo":   "bar",
  "pizza": "cheese"
}
EOT
}



# Deploy aws Module
module "aws" {
    source   = "./aws"
    admin = "${data.vault_generic_secret.bigip.data["admin"]}"
    pass = "${data.vault_generic_secret.bigip.data["pass"]}"
    awsCreds = "${data.vault_generic_secret.aws}"
    prefix = "${var.projectPrefix}"
    adminSrc = "${var.adminSrcAddr}"
   # sshKey = "${var.sshKeyPath}"
}


# out put from sub module
# output "awsCreds" {
#   value = "${module.aws.creds.data["region"]}"
# }


# output "creds" {
#   value = "${data.vault_generic_secret.aws}"
# }
# output "key" {
#   value = "${data.vault_generic_secret.aws.data["access_key"]}"
# }

# output "region" {
#   value = "${data.vault_generic_secret.aws.data["region"]}"
# }