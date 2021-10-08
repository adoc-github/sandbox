aspec_version: 1
kind: TerraForm
inputs:
  - DB_NAME
  - DB_USER
  - DB_PASS
  - SANDBOX_ID
  - VPC_ID
  - role_arn: PowerUserAccess
  # role_arn is a default role that works out of the box in AWS,
  # It is recommended that you create a specific role with relevant permissions and provide its ARN here.

module:
  source: github.com/cloudshell-colony/terraform/rds-mysql
  # The source element is the location of your Terraform module,
  # Both public and private repos are supported


terraform_version: 0.11.11
variables:
  var_file: terraform.tfvars
  values:
    - db_name: $DB_NAME
    - username: $DB_USER
    - password: $DB_PASS
    - sandbox_id: $SANDBOX_ID
    - vpc_id: $VPC_ID
outputs:        # Declaring the outputs from Terraform that will be recognized in this blueprint
  - hostname    # The RDS host name will be used as an input to the application consuming the RDS service
permissions:
  aws:
    role_arn: $role_arn    #role assumed by service