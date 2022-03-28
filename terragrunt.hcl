# dynamically provison the remote state
remote_state {
    backend = "azurerm"
    config = {
    resource_group_name = "terraform-storage-rg"
    storage_account_name = "gopalstatestorage"
    container_name = "tfstate"
    key = "${path_relative_to_include()}.tfstate"
 }
}

#generate the azure provider
generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
    terraform {
        required_providers {
            azurerm = {
                source = "hashicorp/azurerm"
                version = "=2.46.0"
            }
        }
    }
    provider "azurerm" {
        features {}
        skip_provider_registration = "true"
    }
    EOF
}

# we need to ensure that parrelisim do not exceep two modules at a time. 
terraform {
extra_arguments "reduce_parallelism" {
    commands = get_terraform_commands_that_need_parallelism()
    arguments = ["-parallelism=2"]
}

extra_arguments "common_tfvars" {
    commands = get_terraform_commands_that_need_vars()
    required_var_files = [
        "${get_parent_terragrunt_dir()}/vars/common.tfvars"
    ]
}

# terraform auto init
before_hook "auto_init" {
    commands = ["validate", "plan", "apply", "workspace", "output", "import"]
    execute = ["terraform", "init"]
}

before_hook "before_hook" {
    commands = ["terraform plan"]
    execute = ["echo","terraform plan executed"]
    run_on_error = true
}
before_hook "after_hook" {
    commands = ["terraform apply"]
    execute = ["echo","terraform apply executed"]
    run_on_error = false
}
}


