# Infrastructure Bootstrap

This directory contains helper scripts and configuration for bootstrapping Azure resources.

## Usage

1. Run `./azure_bootstrap.sh` once to create the base resource group and virtual network. The script expects the environment variable `AZURE_SUBSCRIPTION_ID` to be set and will write resource IDs to `infra/outputs/bootstrap.json`.
2. After the bootstrap completes, use Terraform for any additional infrastructure:

```bash
make infra-plan
make infra-apply
```

The `infra-plan` target performs `terraform init` and `terraform plan` inside the `infrastructure/` directory, while `infra-apply` applies the generated plan.

## Required Roles

You need at least the **Contributor** role on the target subscription to run these commands.
