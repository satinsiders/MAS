# Makefile ─ top-level
# Run “make <target>” from the repo root.

TERRAFORM  ?= terraform        # allow TF wrapper overrides
DIR        ?= infrastructure  # where *.tf live
ENV_DIR    ?= env/dev         # variable + backend files

PLAN_FILE  ?= plan.out        # name of saved plan

.PHONY: init plan apply fmt validate clean

init:
	$(TERRAFORM) -chdir=$(DIR) init \
		-backend-config=$(ENV_DIR)/backend_override.tfvars

fmt:
	$(TERRAFORM) -chdir=$(DIR) fmt -recursive

validate:
	$(TERRAFORM) -chdir=$(DIR) validate

plan: fmt validate            # fmt → validate → plan
	$(TERRAFORM) -chdir=$(DIR) plan \
		-var-file=$(ENV_DIR)/terraform.tfvars \
		-out=$(PLAN_FILE)

apply:                        # apply the last plan
	$(TERRAFORM) -chdir=$(DIR) apply $(PLAN_FILE)

clean:                        # remove saved plan file
	rm -f $(PLAN_FILE)
