.DEFAULT_GOAL := cluster

init: main.tf vars.tf terraform.tfvars
	terraform init

.terraform/: init

cluster: .terraform/ 
	terraform apply -auto-approve

