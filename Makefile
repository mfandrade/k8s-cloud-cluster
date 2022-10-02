cluster: main.tf vars.tf terraform.tfvars .terraform/
	terraform plan

hard-reset:
	rm -f .terraform.tfstate
	rm -rf .terraform/
