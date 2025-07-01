# Codex Tasks – Bootstrap Foundations

- **README.md** – Draft README with project goal, four-layer agent diagram placeholder, and architecture doc links.
- **.gitignore** – Generate optimized .gitignore for Python, Terraform, and GitHub Actions artifacts.
- **CONTRIBUTING.md** – Write branching strategy and commit-message style guidelines.
- **CODEOWNERS** – Assign project owner as default reviewer for all paths.
- **.pre-commit-config.yaml** – Set up Black, Ruff, isort, and detect-secrets hooks.
- **requirements-dev.txt** – Pin development tooling versions.
- **.github/workflows/ci.yml** – Configure pipeline: lint, test, coverage badge.
- **infra/azure_bootstrap.sh** – Script AZ CLI bootstrap commands with guidance comments.
- **.devcontainer/devcontainer.json** – Dev container definition with Python 3.12, azcli, Terraform, Bicep; post-create hook to run pre-commit install.
- **infrastructure/main.tf** – Define resource group, VNET, and outputs (or main.bicep).
- **Makefile** – Targets `infra-plan` and `infra-apply`.
- **CI infra-plan job** – Extend CI workflow to run terraform plan / bicep what-if and comment diff.
- **.env.example** – Placeholder environment variables.
- **virtual_department/config.py** – Env loader and validator.
- **Project structure** – Create package with stubs: virtual_department/ & agents/, storage/, etc.
- **tests/test_sanity.py** – Sanity imports test.
- **__main__.py** – Add --version flag printing commit SHA.
- **Bootstrap tag snippet** – Append tag creation for `bootstrap-complete` in infra/azure_bootstrap.sh.
