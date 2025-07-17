.PHONY: infra-plan infra-apply init fmt validate

infra-plan: init fmt validate
	terraform -chdir=infrastructure plan \
	  -var-file=env/dev/terraform.tfvars \
	  -out=plan.out

infra-apply:
	terraform -chdir=infrastructure apply "plan.out"

init:
	terraform -chdir=infrastructure init \
	  -backend-config=env/dev/backend_override.tfvars \
	  -upgrade

fmt:
	terraform -chdir=infrastructure fmt -recursive

validate:
	terraform -chdir=infrastructure validate
