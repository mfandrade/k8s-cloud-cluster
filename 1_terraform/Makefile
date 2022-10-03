.DEFAULT_GOAL := cluster

init: main.tf vars.tf terraform.tfvars
	terraform init

plan: .terraform/
	terraform plan -out terraform.plan

cluster: plan
	terraform apply terraform.plan

