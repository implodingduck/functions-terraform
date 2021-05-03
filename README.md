# functions-terraform

## Required stuff
* Terraform (https://www.terraform.io/downloads.html)
* Azure CLI (https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)
* Azure Functions CLI Tool (https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=linux%2Ccsharp%2Cbash)

## Terraform Init
```
source sp-login.sh
env_setup.sh
terraform init --backend-config=backend.tfvars
```

## Terraform plan/apply
```
source sp-login.sh
terraform plan
```

```
source sp-login.sh
terraform apply
```

## Random Notes
* Might need to use `az login`  in order to get the `func` commands to work