.PHONY: infra-plan infra-apply

infra-plan:
terraform -chdir=infrastructure init -upgrade
terraform -chdir=infrastructure plan -out=plan.out

infra-apply:
terraform -chdir=infrastructure apply "plan.out"
